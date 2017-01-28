To run this file, first cd into football_app and then type 

    ruby lib/execute.rb

When prompted input the name of the file you want to check. The file must be located in the "football_app" folder. The results will be displayed in the console. If you just hit enter when prompted the default file, "sample-input.txt" will be used instead. 

To run the tests first install the rspec gem, which can be done with the command: 

    gem install rspec
     
in the command line

Then run the tests from the football_app folder by typing running the command

    rspec

in the command line. This will run all the tests. If you wish to see a more explicit output, run 

    rspec spec --format documentation