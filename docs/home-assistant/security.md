# Securing Home Assistant

## SSL

I wanted to run Home Assistant over SSL, however I am not exposing my instance to the Internet so I didn't need to use a custom dns entry and LetsEncrypt. I also want to use this locally, and LetsEncrypt isn't best suited to that use case. So, I started with a self-signed certificate and soon learned that this was tedious.

At first, I had to always add an exception in my Browser - a needless step. Then I ran into trouble with the iOS and Android Apps not liking the certificate. Although the site was still secure, at this point the other users in the home were also getting annoyed with the extra steps.

### Meet mkcert

I was trying to create my own root certificate, but no matter what combinations I went for there was always some issue or another. Then, I discovered [https://github.com/FiloSottile/mkcert]mkcert.

A simple zero-config tool to make locally trusted development certificates with any names you'd like.

Or, other words it allows me to turn any trusted domain into a trusted domain that I can use.

### Generating your SSL

Most of this section is derrivative art from the perfectly adequate docs. But, here we are. First you'll want to get mkcert installed:

```
brew install mkcert
brew install nss # if you use Firefox
```

No dramas so far. Now let's generate the SSL Certificate. I included the mDNS name and also the IP Address of the server because smetimes my mDNS gets funky and doesn't work.

```
mkcert home-assistant.local "*.local" "IP.OF.YOUR.SERVER"
```

#### Making it work on iOS

Runing this on OSX will open a Finder window to your rootCA.pem file. You can AirDrop or send these files however you see fit to your iOS device.

```
cd "$(mkcert -CAROOT)"
open .
```

### Updating Home Assistant

Edit your `configuration.yaml` file to include the following:

```
http:
  ssl_certificate: ssl/home-assistant.local.pem
  ssl_key: ssl/home-assistant.local-key.pem
```

I didn't specify a port here, so the default port of `8123` will still be used. Restart Home Assistant and you should be all set to access with the `https://` protocol.
