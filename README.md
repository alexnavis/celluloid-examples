# celluloid-examples

## Code

Clone Code & Execute:

    $ bundle install

## Development

Inspect:
 
    script/console.rb 

Run Examples:

Actors :

    script/run.rb ContainerWentMissing
    script/run.rb AsyncInitCrash
    script/run.rb InitCrash
    script/run.rb MultiCrash
    
Actors Hierarchy:

    script/run.rb ParentActorTest
    script/run.rb SupervisorActorHeirarchyTest

Supervisor Groups:

    script/run.rb ChildInitCrashInContainerTest
    script/run.rb MasterContainerCrash

Supervisor Group Under Group:

    script/run.rb SuperGroupTest
    
Misc:

    script/run.rb ThreadContextTest

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/actor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

