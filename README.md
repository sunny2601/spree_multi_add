SpreeMultiAdd
=============

Introduction goes here.

Installation
------------

Add spree_multi_add to your Gemfile:

```ruby
gem 'spree_multi_add'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_multi_add:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.
There is a bug in the test app so any view decorators needs to be precompiled
each time they change. Otherwise it's enough to run rake test_app and rspec
spec.


```shell
bundle
bundle exec rake test_app 
cd spec/dummy/; 
bundle exec rake deface:precompile
cd ../../
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_multi_add/factories'
```

Copyright (c) 2014 [name of extension creator], released under the New BSD License
