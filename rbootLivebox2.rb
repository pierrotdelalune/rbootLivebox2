require "rubygems"
require "celerity"
require "highline/import"

abort $0 + " requires JRuby" unless defined?(RUBY_ENGINE) && RUBY_ENGINE == "jruby"

browser = Celerity::Browser.new
browser.secure_ssl=false

url=ask("url:    ")
browser.goto(url)

login=ask("login:    ")
password=ask("password: ") { |q| q.echo = "x"}

browser.text_field(:name => "authlogin").value=login
browser.text_field(:name => "authpasswd").value=password
browser.link(:title => "Accéder").click

print "Connexion reussie\n" if browser.link(:text => "Déconnexion").exists?
browser.li(:text => "Configuration").click 

print "Onglet de configuration OK\n" if browser.cell(:text => "Dépannage & Maintenance").exists?
browser.cell(:text => "Dépannage & Maintenance").click

print "Page Dépannage & Maintenance ok\n" if browser.link(:text => "Redémarrer").exists? 
browser.link(:id => "linkbutt1").click

print "Print confirmation de redemarrage OK\n" if browser.cell(:text => "Oui").exists?
#browser.link(:text => "Oui").click
#
#print "Redemarrage en cours\n" if browser.contains_text("Veuillez patienter")
