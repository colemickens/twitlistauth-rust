build:
	cargo build

build-release:
	cargo build --release

run: build
	source /etc/twitlistauth/twitlistauth.config; \
	export TWITLISTAUTH_APPID; \
	export TWITLISTAUTH_APPSECRET; \
	export TWITLISTAUTH_HOSTNAME; \
	export TWITLISTAUTH_SERVEROOT; \
	export TWITLISTAUTH_LISTID; \
	export TWITLISTAUTH_PORT; \
	export TWITLISTAUTH_SESSIONSECRET; \
	cargo run

run-release:
	source /etc/twitlistauth/twitlistauth.config; \
	export TWITLISTAUTH_APPID; \
	export TWITLISTAUTH_APPSECRET; \
	export TWITLISTAUTH_HOSTNAME; \
	export TWITLISTAUTH_SERVEROOT; \
	export TWITLISTAUTH_LISTID; \
	export TWITLISTAUTH_PORT; \
	export TWITLISTAUTH_SESSIONSECRET; \
	cargo run --release

install-systemd: build-release
	sudo mkdir -p /etc/twitlistauth
	sudo cp systemd/twitlistauth.config /etc/twitlistauth/
	sudo cp systemd/twitlistauth.service /etc/systemd/system/
	sudo cp systemd/twitlistauth.timer /etc/systemd/system/
	sudo systemctl enable twitlistauth.service
	sudo systemctl enable twitlistauth.timer
	sudo systemctl start twitlistauth.service
	sudo systemctl start twitlistauth.timer

uninstall-systemd:
	sudo systemctl stop twitlistauth.service
	sudo systemctl stop twitlistauth.timer
	sudo systemctl disable twitlistauth.service
	sudo systemctl disable twitlistauth.timer
	sudo rm /etc/systemd/system/twitlistauth.service
	sudo rm /etc/systemd/system/twitlistauth.timer
	sudo rm -r /etc/twitlistauth
