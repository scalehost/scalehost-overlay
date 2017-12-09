# Scalehost Gentoo Overlay

This is a simple overlay for Gentoo with various packages used and/or created by scalehost and/or third parties relating to scalehost.

## Install

To use the repository in accordance with the current Portage specifications, please create the following content in a file in `/etc/portage/repos.conf/`

```
[scalehost]
location = /usr/local/portage/scalehost
sync-type = git
sync-uri = https://github.com/scalehost/scalehost-overlay
```

Or you can add it using layman:  

`layman -o https://github.com/scalehost/scalehost-overlay/blob/master/repo.xml -a scalehost`