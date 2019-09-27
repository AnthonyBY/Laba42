# How to install Homebrew, RVM, Ruby & Rails on MacOS

#### Is Xcode Already Installed?
You don’t need the full Xcode package to get the Xcode Command Line Tools. You only need the full Xcode package if you are doing development of applications for the Apple operating systems. However, you may have previously installed the full Xcode package.

Check if the full Xcode package is already installed:

    $ xcode-select -p

If you see:

    xcode-select: error: unable to get active developer directory...

The Xcode package is not installed. Jump to the next section and install only the Xcode Command Line Tools.

If you see:

    /Applications/Xcode.app/Contents/Developer

or

    /Library/Developer/CommandLineTools

The full Xcode package is already installed. Maybe you or someone else installed it previously.

If you intend to install Ruby using RVM, and you see a file location that contains spaces in the path:

    /Applications/Apple Dev Tools/Xcode.app/Contents/Developer

you must delete Xcode. [RVM cannot accommodate spaces in a path](http://rvm.io/support/faq#can-i-use-a-path-with-spaces) so RVM will fail when you attempt to install Ruby. You can either install only the Xcode Command Line Tools (instructions below) or reinstall the full Xcode package.

## Install Xcode Command Line Tools

The Xcode Command Line Tools provide a C language compiler needed to install Ruby. For many Rails projects, you will need the C language compiler to install gems that use native extensions.

macOS High Sierra will alert you when you enter a command in the terminal that requires Xcode Command Line Tools. For example, you can enter `gcc`, `git`, or `make`.

Try it. Enter:

    $ gcc

If Xcode Command Line Tools are not installed, you’ll see an alert box:

Alternatively, you can use a command to install Xcode Command Line Tools. It will produce a similar alert box. Note the double hyphen:

    $ xcode-select --install

Click “Install” to download and install Xcode Command Line Tools.

The instructions in the alert box are confusing. You don’t need to "Get Xcode" from the App Store. Just click "Install" for the Xcode Command Line Tools. If you have a slow Internet connection, it may take many minutes.

If the download takes a very long time (over an hour) or fails, you can try an alternative. Go to https://developer.apple.com/downloads/more and enter your Apple ID and password. You'll be asked to agree to the terms of the Apple Developer Program. You'll see a list of software packages you can download. Look for the latest version of Command Line Tools and click to download the .dmg file. Downloading the .dmg file is much faster than waiting for the command-line-based download. Install the .dmg file by clicking on the package icon.

Verify that you’ve successfully installed Xcode Command Line Tools:

    $ xcode-select -p

    /Library/Developer/CommandLineTools

The Xcode Command Line Tools must be installed before you go to the next steps. Just to be certain, verify that gcc is installed:

  $ gcc --version

    Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
    Apple LLVM version 10.0.0 (clang-1000.10.44)
    Target: x86_64-apple-darwin17.5.0
    Thread model: posix

#### Ignore the Alternatives

You might hear about the [OSX GCC Installer](https://github.com/kennethreitz/osx-gcc-installer), an open source project to provide the GCC compiler and related tools. In the blog post, [Xcode, GCC, and Homebrew](http://kennethreitz.org/xcode-gcc-and-homebrew/), the project maintainer recommends installing the Xcode Command Line Tools because the open source project is unable to duplicate the complete Apple package (notably, the Node software project isn’t supported).

## Install Homebrew

*Note: If you did not use a password to log in to your Mac (that is, if your password is blank), you cannot install Homebrew.*

Check if Homebrew is installed:

    $ brew -v

    -bash: brew: command not found

RVM requires [Homebrew](http://brew.sh/), a package manager for macOS. Many developers use Homebrew to install various Unix software packages.

To avoid RVM installation issues, install Homebrew before RVM. So if Homebrew is not installed, install it:

    /usr/bin/ruby -e "$(curl - fsSLhttps://raw.githubusercontent.com/Homebrew/install/master/install)"

If you see:

    $ brew -v

    Homebrew 2.1.11
    Homebrew/homebrew-core ()

The Homebrew is already installed. Maybe you or someone else installed it previously.

## Install RVM(Ruby Version Manager)

A better alternative to using the system Ruby is to install Ruby with RVM, the Ruby Version Manager. RVM is a tool for installing different versions of Ruby itself. RVM has the following advantages:
* RVM enables you to install multiple versions of Ruby and allows you to change which version you want to use.
* RVM installs each version of Ruby in a hidden folder in your home folder so each version of Ruby you install doesn’t affect the system Ruby.
* Gems installed by RVM-managed versions of Ruby are installed within the hidden folder in your home folder containing that version of Ruby.
* You won’t need use sudo to install gems.

If your Mac user name contains a space character, you must [change you account name](http://support.apple.com/kb/HT1428) to remove the space.

### Verifying the installation source

The first step is to install the mpapis public key. However, as the install page notes, you might need gpg. Mac OS X doesn’t ship with gpg so before installing the public key, you’ll need to install gpg.

    $ brew install gnupg gnupg2

    $ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

When run, this command will add the given keys to your local key store and enable verification of the RVM installation and display the following output:

    gpg: directory '/Users/peter.grainger/.gnupg' created
    gpg: keybox '/Users/peter.grainger/.gnupg/pubring.kbx' created
    gpg: key 105BD0E739499BDB: 5 signatures not checked due to missing keys
    gpg: /Users/peter.grainger/.gnupg/trustdb.gpg: trustdb created
    gpg: key 105BD0E739499BDB: public key "Piotr Kuczynski <piotr.kuczynski@gmail.com>" imported
    gpg: key 3804BB82D39DC0E3: 105 signatures not checked due to missing keys
    gpg: key 3804BB82D39DC0E3: public key "Michal Papis (RVM signing) <mpapis@gmail.com>" imported
    gpg: no ultimately trusted keys found
    gpg: Total number processed: 2
    gpg: imported: 2

The above output shows that two public keys have been added to a local store. When RVM is installed, the release will be checked against these keys to verify the file came from the correct source.

### Installing RVM

All other operating systems are configured by following one step that downloads a script using curl, which it then executes using Bash. Don’t use root when running this script; it will install RVM as the root user, and it won’t work correctly for any other user. Enter the following into the terminal:

    $ \curl -L https://get.rvm.io | bash -s stable

*Note: the backslash before "curl" (this avoids potential version conflicts).*

After the installation completes, close the Terminal window and open a new one to make sure that Terminal picks up any environment changes.

RVM includes an "autolibs" option to identify and install components needed for your operating system. See the article [RVM Autolibs: Automatic Dependency Handling and Ruby 2.0](https://blog.engineyard.com/2013/rvm-ruby-2-0) for more information. RVM will update your system and install dependencies required for installing Ruby on macOS.

You may see a message:

    mkdir: /etc/openssl: Permission denied
    mkdir -p "/etc/openssl" failed, retrying with sudo
    your password required for 'mkdir -p /etc/openssl':

If you see the message, enter your Mac password.

You may be prompted to install a Java SE 6 runtime (for the javac Java compiler).

## Install Ruby

To install a version of Ruby using RVM, use the command rvm install <version number>. So to install version 2.6.3 of Ruby enter the following into the terminal:

    $ rvm install 2.6.3

Depending on your operating system, the above command may use precompiled binaries or compile the Ruby binaries from source. If compiling from source, this may take a long time to complete.

To check this installation worked correctly and the current version of Ruby, run the following in the terminal:

    $ ruby -v

This will show the current version of Ruby running in the terminal. The output should be similar to this:

    ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin18]

## Install Nodejs

The first thing you should do is check to see if you have a version of Node.js already installed. To do that:

    $ node -v

If you see:

    12.10.0

This is the version nodejs you already have installed. Just to be sure, run command in terminal:

    $ npm -v

If you see:

    6.36.0

Then you have Node.js and npm successfully installed, otherwise run in the terminal:

    $ brew install node

Test  it!

Make sure you have Node and NPM installed by running simple commands to see what version of each is installed:

* Test Node. To see if Node is installed, type `node -v` in Terminal. This should print the version number so  you’ll see something like this v`12.10.00`.
* Test NPM. To see if NPM is installed, type `npm -v` in Terminal. This should print the version number so you’ll see something like this `6.36.0`

## Install Postgresql

    $ Psql --version

    $ brew install postgresql

    $ brew service start postgresql

## Update GIT

    $ brew install git

## Install yarn

    $ brew install yarn

Now that the environment is set up, you can start [deploying the application itself](CONTRIBUTING.md#clone-the-Laba42-Repository).
