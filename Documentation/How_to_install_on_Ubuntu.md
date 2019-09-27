## How to install RVM, Ruby & Rails on Ubuntu

### Prerequisites

If you are using Ubuntu 16.04 as a first step, you need to update the repository to install a newer version of node js.  
If the version is Ubuntu 18.04 and later you can skip this step.

    $ curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

Then you will need to configure the yarn package repository:

    $ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    $ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

### Install all required tools

    $ sudo apt update

    $ sudo apt install curl git nodejs yarn postgresql libpq-dev


### Install RVM(Ruby Version Manager)

We first need to update GPG, which stands for GNU Privacy Guard, to the most recent version in order to contact a public key server and request a key associated with the given ID.

    $ sudo apt install gnupg2

    $ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

*Note: In case you encounter an issues check http://rvm.io/rvm/security*

After the installation is complete, you should check the Run command as a login shell in the terminal. And reload it (close and reopen)

### Install Ruby

To install a version of Ruby using RVM, use the command rvm install <version number>. So to install version 2.6.3 of Ruby enter the following into the terminal:

    $ rvm install 2.6.3

Depending on your operating system, the above command may use precompiled binaries or compile the Ruby binaries from source. If compiling from source, this may take a long time to complete.

To check this installation worked correctly and the current version of Ruby, run the following in the terminal:

    $ ruby -v

This will show the current version of Ruby running in the terminal. The output should be similar to this:

    ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin18]

### Install Bundler

Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.

    $ gem install bundler

At this point, you can begin [deploying the laba42 application](CONTRIBUTING.md#clone-the-Laba42-Repository).
