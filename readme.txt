rails new test -d postgresql -T

rails db:create

ps aux | grep post

subir serviços

brew services start postgresql

==========================================================

rails new sugar_market -d postgresql -T



Gem file:

gem 'bcrypt', '~> 3.1.7'
gem 'cancancan'
gem 'simple_form'
gem 'friendly_id'
gem 'carrierwave'
gem 'bootstrap-sass'
gem 'cocoon'
gem 'aasm'
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'sinatra', '2.0.0.beta2'
gem "font-awesome-rails"
gem 'letter_opener'
gem 'geocoder'


--------------------------------------------
development:

gem 'letter_opener'
  gem 'faker'
  gem 'awesome_print'
  gem 'interactive_editor'
  gem 'hirb'
  gem 'rails-erd'

########################################################

rails g model product title:string description:text calories:integer
rails g model customer first_name last_name email phone password_digest

rails db:create

rails g controller customers
rails g controller products
rails g controller sessions

rails g migration  add_address_to_customers address:string
rails db:migrate

rails generate simple_form:install --bootstrap
#########################################################
rails g cancan:ability
rails g migration add_is_admin_to_customers is_admin:boolean

Ajustar db/migrate
add_column :customers, :is_admin, :boolean, default: false
rails db:migrate

#########################################################

Admin Console

gem 'inherited_resources', '~> 1.7'
gem 'activeadmin', '1.0.0.pre5'
gem 'devise'

bundle

rails g active_admin:install 

rails db:migrate

http://localhost:3000/admin/

rails c

AdminUser.create(email: 'fernando@huber.com' ,  password: 'p0o9i8u7' )


rails g active_admin:resource customer
rails g active_admin:resource product
rails g active_admin:resource flavour

rails g active_admin:resource amount
rails g active_admin:resource type
rails g active_admin:resource production
rails g active_admin:resource order
rails g active_admin:resource event


#########################################################
Password Reset

rails g migration add_reset_to_customers

add_column :customers, :reset_digest, :string
add_column :customers, :reset_sent_at, :datetime

rails g migration add_activation_to_customers

add_column :customers, :activation_digest, :string
    add_column :customers, :activated, :boolean, default: false
    add_column :customers, :activated_at, :datetime

rails g migration add_remember_digest_to_customers

add_column :customers, :remember_digest, :string

##########################################################
em controller @auctions = Auction.pluck(:title)

na pagina
<%= f.input :title, as: :select, collection: @auctions %>


##########################################################

rails g controller passwords_resets_controller


##########################################################
brew install imagemagick

https://github.com/thoughtbot/paperclip
gem "paperclip", "~> 5.0.0"

rails g migration add_image_to_products

def change
    add_column :products, :image, :string
  end

-------------------------------------------------------------------------


https://github.com/carrierwaveuploader/carrierwave

rails generate uploader image

 rails generate uploader image


MIniMagick

para gerar imagens pequenas

brew install imagemagick (para MAC)

###########################################################

rails g model product title:string description:text calories:integer

rails g model flavour flavour:string
rails g model ingredient ingredient:string
rails g model amount unit:string quantity:integer
rails g model type type:string

rails db:migrate


rails g migration  add_flavour_id_to_amount
rails g migration  add_ingredient_id_to_amount
rails g migration  add_product_id_to_type
rails g migration  add_product_id_to_flavour
rails g migration  add_amount_id_to_flavour



def change
    add_reference :amounts, :flavour, foreign_key: true
  end

def change
    add_reference :amounts, :ingredient, foreign_key: true
  end

-----------------------------------------------------------------------------
add to admin_console

rails g active_admin:resource type
rails g active_admin:resource ingredient
rails g active_admin:resource amount
rails g active_admin:resource flavour

###########################################################
Search Engine

https://github.com/Casecommons/pg_search

rails g pg_search:migration:multisearch
rails db:migrate

config/initializers
criar: multisearch.rb

ir em models e definir:

include PgSearch
  multisearchable :against => [:type_of]

PgSearch.multisearch_options = {
  using: {
    tsearch: { 
      dictionary: 'english',
      prefix: true,
      any_word: true,
      normalization: 2
     }
  }
}

no terminal:

psql sugar_market_development (nome do db >>config/database.yml)
CREATE EXTENSION fuzzystrmatch;



rails g pg_search:migration:dmetaphone
rake db:migrate

initializer  o db:

PgSearch::Multisearch.rebuild(Type)
PgSearch::Multisearch.rebuild(Igredients)

config/initializer

PgSearch.multisearch_options = {
  using: {
    tsearch: { 
      dictionary: 'english',
      prefix: true,
      any_word: true,
      normalization: 2
     }
  }
}

-----------------------------------------------------------------------------

examples:

PgSearch.multisearch("sugar mi pota")
Product.search_by_title('cake')
Product.search_by_title('cake').where('calories > ?', 1000)
Flavour.where(amount_id: 1)

Flavour.joins(product: :types).where(types: {id: 1})

Flavour.joins(product: :types).where(types: {id: 3})


product_with_vanilla_and_gluten_free = product_with_vaniall_bean.select{|p| p.types.select{|t| t.type_of.downcase == "gluten free"}}

-------------------------------------------------------------------------------
==========================================================

rails g model production quantity:integer

rails g model order order:integer
rails g model event type:string  nun_people:integer event_date:date delivery_date:date

rails db:migrate


rails g migration  add_product_id_to_production

def change
    add_reference :productions, :product, foreign_key: true
  end

rails g migration  add_order_id_to_production

def change
    add_reference :productions, :order, foreign_key: true
  end

rails g migration  add_production_id_to_order

def change
    add_reference :orders, :production, foreign_key: true
  end


rails g migration  add_customer_id_to_order

def change
    add_reference :orders, :customer, foreign_key: true
  end

rails g migration  add_event_id_to_order

def change
    add_reference :orders, :event, foreign_key: true
  end

=========================================================
geocoder:
https://github.com/alexreisner/geocoder

https://developers.google.com/maps/documentation/embed/guide

rails g migration add_lng_lat_to_customers longitude:float latitude:float


rails db:migrate


===========================================================

rails g model location

===========================================================

rails g model review body:string rating:integer
