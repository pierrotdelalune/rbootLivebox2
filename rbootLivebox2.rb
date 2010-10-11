# == Synopsis
#
# rbootLivebox2: Celerity scenario to automatically reboot a Sagem Livebox 2 by Orange
#
# == Usage
#
# rbootLivebox2 [OPTION] ... URL
#
# -h, --help:
#    show help
#
# --dryrun:
#    go through each step of the scenario but does not reboot the Livebox 2
#
# URL: The URL of the Livebox 2

require "rubygems"
require "celerity"
require "highline/import"
require "getoptlong"
require "rdoc/usage"

abort $0 + " requires JRuby" unless defined?(RUBY_ENGINE) && RUBY_ENGINE == "jruby"

opts = GetoptLong.new(
         [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
         [ '--dryrun', GetoptLong::NO_ARGUMENT ]
         )

dryrun=false
opts.each do |opt, arg|
   case opt
      when '--help'
        RDoc::usage
      when '--dryrun'
         dryrun=true
   end
end

if ARGV.length != 1
   puts "Missing url argument (try --help)"
   exit 1
end

url=ARGV.shift

browser = Celerity::Browser.new
# The SSL certificate is self signed and hostname in certificate does match hostname in url
browser.secure_ssl=false

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

unless dryrun
   browser.link(:text => "Oui").click

   print "Redemarrage en cours\n" if browser.contains_text("Veuillez patienter")
end
