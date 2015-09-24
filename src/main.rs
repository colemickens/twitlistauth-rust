extern crate iron;
extern crate staticfile;
extern crate mount;

use std::env;
use std::path::Path;

use iron::Iron;
use staticfile::Static;
use mount::Mount;

/*

¯\_(ツ)_/¯

TWITLISTAUTH_APPID=
TWITLISTAUTH_APPSECRET=
TWITLISTAUTH_HOSTNAME=
TWITLISTAUTH_SERVEROOT=
TWITLISTAUTH_LISTID=
TWITLISTAUTH_PORT=
TWITLISTAUTH_SESSIONSECRET=
*/

fn main() {
    let mut mount = Mount::new();

    let serve_root = env::var("TWITLISTAUTH_SERVEROOT").ok().expect("must set TWITLISTAUTH_SERVEROOT");
    let serve_port_str = env::var("TWITLISTAUTH_PORT").ok().expect("must set TWITLISTAUTH_PORT");
    let serve_port = serve_port_str.parse::<u16>().ok().expect("TWITLISTAUTH_PORT must be an unsigned integer");

    mount.mount("/files/", Static::new(Path::new(&serve_root)));

    let iron_serve = ("0.0.0.0", serve_port);
    Iron::new(mount).http(&iron_serve).unwrap();
}
