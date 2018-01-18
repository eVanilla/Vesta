<p align="center"><img src="./banner.png" alt="Vesta banner" align="center" /></p>

# Vesta

A simple ruby decentralized p2p messenger with E2EE __(end-to-end-encryption, that means nobody can read your messages without your private-key so then keep it secret!, for more information about how does rsa or public-key encryption works click <a href="https://en.wikipedia.org/wiki/RSA_(cryptosystem)">here</a>)__

it need more improvements, but it does the job.

[![Status](https://img.shields.io/badge/status-works%20fine-9d67e4.svg?style=for-the-badge)](https://github.com/eVanilla/Vesta)
[![Downloads](https://img.shields.io/gem/v/vesta-chat.svg?style=for-the-badge)](https://rubygems.org/gems/vesta-chat)

## Screenshot

<p align="center"><img src="./screenshot.png" alt="Vesta screenshot" align="center" /></p>

## Installation

first of all you'll need to install ```ruby``` 

Add this to your Gemfile
```
gem 'vesta-chat'
```
and then execute
```
$ bundle install
```
or install it yourself as
```
$ gem install vesta-chat --no-ri --no-rdoc
```

## Usage

it's not too complicated.

Running a node:
```
$ vesta '[your_ip]' [your_port]
# eg.
$ vesta 'http://localhost' 1000
# and you're ready to open this (http://localhost:1000) page on your browser.  
``` 
Connecting to a node:
```
$ vesta '[your_ip]' [your_port] '[peer_ip]' [peer_port]
# eg.
$ vesta 'http://localhost' 1000 'http://localhost' 2000
# and you're ready to open this (http://localhost:1000) page on your browser.  
```

### Improvements that can be made
* Secure private chats
* Better ui
* Better code style
* &...

**Also if you liked it.. you can just hit that star button to make me happy!**
