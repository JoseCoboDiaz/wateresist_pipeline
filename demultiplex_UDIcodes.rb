#AATGATACGGCGACCACCGAGATCTACAC -- i5 UDIcode -- ACACTCTTTCCCTACACGACGCTCTTCCGATC
#CAAGCAGAAGACGGCATACGAGAT -- i7 UDIcode -- GTGACTGGAGTTCAGACGTGTGCTCTTCCGATC

hsample={}
#UDI    i5      i5      i7
#UDI001  CGACCATT        AATGGTCG        GCCTATCA
aa=File.open("UDI_codes.txt").each_line do |line|
line.chomp!
col=line.split("\t")
puts col[0]
hsample[col[1]]=col[0]
hsample[col[2]]=col[0]
hsample[col[3]]=col[0]
hsample[col[3].reverse.tr('ACGT','TGCA')]=col[0]
end
aa.close

puts hsample
`mkdir #{ARGV[1]}`

read=''
n=0
m=0 # to double count if both primers are found
bb=File.open(ARGV[0]).each_line do |line|
line.chomp!
#if line =~ /ATCTACAC(\w{8})ACACTCTT/ or /AAGAGTGT(\w{8})GTGTAGAT/ or /TACGAGAT(\w{8})GTGACTGG/ or /CCAGTCAC(\w{8})ATCTCGTA/
if line =~ /^>(\S+)\s+/
read=$1
end
m=0
if line =~ /CTACAC(\w{8})ACACTC/ or line =~ /GAGTGT(\w{8})GTGTAG/
#puts "#{read}\t#{hsample[$1]}"
        if hsample[$1]!=nil
        `echo #{read} >> #{ARGV[1]}/#{hsample[$1]}.txt`
        n+=1
        m+=1
        end
#       if hsample[$1]==nil and line =~ /CGAGAT(\w{8})GTGACT/ or line =~ /AGTCAC(\w{8})ATCTCG/
#       puts "repesca #{read}\t#{hsample[$1]#               if hsample[$1]!=nil
#               `echo #{read} >> #{ARGV[1]}/#{hsample[$1]}.txt`
#               n+=1
#               end
        end
if line =~ /CGAGAT(\w{8})GTGACT/ or line =~ /AGTCAC(\w{8})ATCTCG/ and m!=1
#puts "#{read}\t#{hsample[$1]}"
        if hsample[$1]!=nil
        `echo #{read} >> #{ARGV[1]}/#{hsample[$1]}.txt`
        n+=1
        end
#if line =~ /ACAC(\w{8})ACAC/ or /GTGT(\w{8})GTGT/ or /AGAT(\w{8})GTGA/ or /TCAC(\w{8})ATCT/
#puts $1
end
end
bb.close
puts n

  
