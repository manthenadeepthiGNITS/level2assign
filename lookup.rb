def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

def parse_dns(rec)
  noEmptyRecords = rec.reject { |c| c=="\n" || c[0]=='#'}
  hsh = {}
  noEmptyRecords.each{ |precord|
    k=precord.split()
    k[0]=k[0].chop
    k[1]=k[1].chop
    hsh[k[1]] = {type:k[0],target:k[2]}}
    #puts hsh
  return(hsh)
end

def resolve(dns_records,lookup_chain,domain)
  record = dns_records[domain]
  if (!record)
    domain=lookup_chain[0]
    lookup_chain[0]="Error: Record not found for "
    lookup_chain[1]=domain
    return lookup_chain
  elsif record[:type] == "CNAME"
    lookup_chain.push(dns_records[domain][:target])
    resolve(dns_records,lookup_chain,dns_records[domain][:target])
  elsif record[:type] == "A"
    lookup_chain.push(dns_records[domain][:target])
  end
end

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
