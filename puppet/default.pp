exec { 'apt-get-update':
  command => 'apt-get update',
  path    => [ '/usr/bin' ],
}

package { [ 'build-essential', 'curl', 'git', 'vim', 'nodejs', sqlite3',
            'libsqlite3-0', 'libsqlite3-dev', 'libcurl4-openssl-dev', 'libpcre3-dev' ]:
  ensure  => installed,
  require => Exec['apt-get-update'],
}

# curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --ruby
# source /home/vagrant/.rvm/scripts/rvm
# gem install puppet pry httparty rails --no-ri --no-rdoc

# export RAILS_ENV=development
# export SPCH_SECRET_KEY=(rake secret)
