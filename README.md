# RedPotion Generators

This command line tool provides additional generators that aren't currently available from RedPotion. Some of these generators include:

* CDQ Model/Schema Generator
* CDQ Table Screen Generator
* PM::XLFormScreen Generator
* Scaffolding Generator

By having additional generators for CDQ and PM::XLForm, this gem is able to provide a scaffolding generator, similar to that of Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redpotion-generators'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redpotion-generators

## Usage

Once you have installed the gem, the generators are available under a `rp` command.

### Scaffolding Generator

    rp scaffold blog_post title:string body:text published:boolean publish_date:datetime

### CDQ Generators

    rp cdq_model blog_post title:string body:text published:datetime
    rp cdq_table_screen blog_posts

### PM::XLFormScreen Generator

Currently only available by using the scaffolding generator.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewhavens/redpotion-generators.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
