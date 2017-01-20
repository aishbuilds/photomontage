# Photomontage

Photomontage is a ruby gem that accepts search keywords provided by the user, fetches images that are relevant to the words, and collates them into a collage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'photomontage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install photomontage

## Installation dependencies

1. Ensure you have ImageMagick (https://www.imagemagick.org/script/binary-releases.php) installed in your system.

2. Troubleshooting installation of rmagick gem (https://github.com/rmagick/rmagick/#user-content-wrong)

## Usage

Open Ruby interactive shell:

    $ irb

Require photomontage gem:

```ruby
> require 'photomontage'
```

Build your collage!
	
```ruby
> Photomontage.begin
```
    
To view the collage image, exit from irb:

```ruby
> exit
```
    
    $ open images/file_name.jpg

## Contributing

1. Fork it ( https://github.com/aishwarya923/photomontage/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
