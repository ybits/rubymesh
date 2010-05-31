# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rubymesh_session',
  :secret      => 'eccd5981508d37b0c0bf6772256c3f76bf0a1a22007517ed3415a1cc0e3c26dde1a375c4b70083a8f7f86010cdaf529fe16380f2a575d992c227064df2c72a4f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
