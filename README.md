# syno-code-server

VS Code in the browser for Synology NAS, powered by [code-server](https://github.com/coder/code-server).

## Installation

1. Download the `.spk` for your NAS architecture from [Releases](../../releases)
2. In DSM go to **Package Center → Manual Install** and select the `.spk`
3. The install will fail to start — this is expected. SSH into your NAS and run:
   ```sh
   sudo sed 's/package/root/g' -i /var/packages/code-server/conf/privilege
   sudo synopkg start code-server
   ```
4. Open **JS - Editor** from the DSM desktop, or go to `http(s)://<ip>:<port>/code-server/`

## Configuration

Config file lives at `/var/packages/code-server/target/etc/code-server.yaml`.  
Restart the package after changes: `sudo synopkg restart code-server`

Default settings:
- Port: `17682` (internal, proxied via nginx)
- Auth: none (DSM provides authentication)
- Base path: `/code-server`
- User data (extensions, settings): `/var/packages/code-server/var/data`

## Architecture support

| Target | Architecture |
|--------|-------------|
| x64-7.0 / x64-7.2 | Intel/AMD 64-bit |
| aarch64-7.0 / aarch64-7.2 | ARM 64-bit |
