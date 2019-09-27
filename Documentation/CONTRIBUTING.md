# Contributing to Laba42

First off, thank you for considering contributing to Laba42. It's people like you that make Laba42 a better.

## Setting Up a Development Environment

To move on from submitting bugs to helping resolve existing issues or contributing your own code to Laba42 project, you must be able to run its in developments enviroment. In this section of the guide, you'll learn how to setup this enviroment on your own computer.

Laba42 Projects requires on additional services and tools that you need to install before running.

Requirements:
* Ruby 2.6.3.
* Postgresql
* Node.js 8.10 or later
* Yarn
* Bundler
* Git

*Note: The safest bet is to use [rvm](https://github.com/wayneeseguin/rvm) with an rvm
installed ruby (not system ruby) and a clean gemset dedicated to laba42.
[rbenv](https://github.com/sstephenson/rbenv) is also supported.*

Below you can find instructions on how to install all of the additional tools for different OSes.

* [macOS](How_to_install_on_MacOS.md)
* [Ubuntu](How_to_install_on_Ubuntu.md)

If you have already installed and configured everything you need for the lab42, then you can immediately proceed with the build on your local machine.

### Clone the Laba42 Repository

Navigate to the folder where you want the Laba42 source code (it will create its own Laba42 subdirectory) and run:

    $ git clone https://github.com/AnthonyBY/Laba42.git
    $ cd Laba42


Install all of the required gems

    $ bundle install


Verify that already installed files in node_modules did not get removed or corrupted

    $ yarn install --check-files


### Postgresql Configuration

Now we need to specify the user for the database. In this example, we will create a user named laba42. You can invent or use another user. Information about him must be entered in the **config/database.yml.example** file (lines 5-6) and saved as **config/database.yml**. After successfully creating the user, use the following command, and when prompted for a password, enter the password that you specified in the database.yml file.

    $ sudo -u postgres createuser -s -d -r -P laba42

*Note: If you are using MacOS, you need to replace `postgres` on the your OS username.  
       Entered password characters are not displayed.  
       Username should be used in lowercase to avoid unexpected errors.*

Then create database and run migrations:

    $ rails db:create
    $ rails db:migrate

If necessary, you can add the source data after creating the database. This project has a built-in "seed" function, which makes the process quick and easy. This is especially useful when frequently reloading the database in development and testing environments. It's easy to get started with this feature: just run

    $ rails db:seed

*Note: This is not necessary now, and can be done later if you want.*

### Run Application

Build of the project is complete. To start it, use the command in the terminal

    $ rails server
