# Proforma

[![Gem Version](https://badge.fury.io/rb/proforma.svg)](https://badge.fury.io/rb/proforma) [![Build Status](https://travis-ci.org/bluemarblepayroll/proforma.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/proforma) [![Maintainability](https://api.codeclimate.com/v1/badges/71ab6d000e617989b3e1/maintainability)](https://codeclimate.com/github/bluemarblepayroll/proforma/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/71ab6d000e617989b3e1/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/proforma/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Proforma is a Ruby-based document rendering framework with a focus on being:

1. Configurable: the virtual document model allows templates to be defined as configuration
2. Simple: basic set of controls that limit flexibility but increase simplicity and standardization
3. Extendable: different value resolvers and document rendering engines can be plugged in

The basic premise is you input a dataset and a template and Proforma:

1. Evaluate and data-bind each component
2. Render as a file

When a component is in the process of being data-bound it will be evaluated against the current data being read.  The evaluator serves two purposes:

1. Given a record and an expression, find me a raw value (resolving)
2. Given a record and an expression, return me a formatted string-based value (text templating)

The basic evaluator that comes with this library is Proforma::HashEvaluator.  It is limited to:

1. only resolving values for hash objects and cannot handle nesting / recursion / dot notation.
2. only text templating simple expressions: if the expression starts with a ```$:``` then it is noted as being a data-bound value.  The value proceeding the ```$:``` will be resolved and returned.  If it does not begin with this special string then it is deemed just a basic string and it will be returned verbatim.

Other libraries that can be plugged in, such as:

1. [![proforma-extended-evaluator](https://github.com/bluemarblepayroll/proforma-extended-evaluator): adds nested dot-notation object value resolution and rich text templating.
2. [![proforma-prawn-renderer](https://github.com/bluemarblepayroll/proforma-prawn-renderer)]: adds PDF rendering.

See the libraries respective README files for more information.

## Installation

To install through Rubygems:

````
gem install install proforma
````

You can also add this to your Gemfile:

````
bundle add proforma
````

## Examples

*The examples in this library will be based on the default plugins that are contained within package and thus will be as bare bones as they can be.  See other plugin library documentation to see how the input and output can be greatly enhanced.*

## Virtual Document Object Model Introduction

The following is a list of components that can be used for modeling:

* Banner: define image, title, and details
* DataTable: define columns with header, body, and footer contents
* Grouping: one-to-many dataset traversal
* Header: large, bold text
* Pane: define columns and lines (akin to a details section)
* Separator: draw a line
* Spacer: blank space below component
* Text: basic text

Most aspects of the components will be data-bound.

### Getting Started: Rendering a List

Let's say we have a list of users:

````ruby
data = [
  { id: 1, first: 'Matt', last: 'Preamble' },
  { id: 2, first: 'Katie', last: 'Dolphin' },
  { id: 3, first: 'Timmy', last: 'Smith' }
]
````

We could render this using the following template:



### Rendering Record Details

### Putting it all Together



## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check proforma.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/proforma.git)
4. Navigate to the root folder (cd proforma)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/proforma/version.rb``` using [semantic versioning](https://semver.org/)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Build the project locally: `gem build proforma`
7. Publish package to RubyGems: `gem push proforma-X.gem` where X is the version to push
8. Tag master with new version: `git tag <version>`
9. Push tags remotely: `git push origin --tags`

## License

This project is MIT Licensed.
