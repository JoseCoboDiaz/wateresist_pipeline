
samples=[]
gen=[]
hsamples={}
hgen={}
sample=''


`ls #{ARGV[0]} | sed 's/blastn_//g' | sed 's/.txt//g' > list_samples_reads_WMS.txt`

listado=File.new("blastn_all_WMS.txt","w")

aa=File.open("list_samples_reads_WMS.txt").each_line do |file|
file.chomp!
sample=file.split("\.")[0]
samples << sample
#NODE_4_length_281663_cov_152.962804     blaADC-25_1_EF016355    97.309  1152    31      0       108888  110039  1152    1       0.0     1956    1152    TTATTTCTTTATTGCAC
#18ac5dd7-4e83-4653-b37f-2a70e6f5d444    lnu(A)_1_M14039 94.652  187     6       4       233     415     486     300     3.54e-78        287     486     TTA
#d645c6c2-2243-4495-9b6d-a205cfb8478b	qnrB19_1_EU432277	92.496	653	29	16	228	868	1	645	0.0	917	1098	645

bb=File.open("#{ARGV[0]}/blastn_#{file}.txt").each_line do |line|
line.chomp!
col=line.split("\t")
#ver que columna ocupa e  longitud de la secuencia objeto (qlength) y la longitud del alineamiento (length) y dividir length entre qlentgh OJO empezar a contar en col 0
puts col[13].to_f/col[3].to_f
if col[2].to_f > 80 and 100*col[3].to_f/col[13].to_f > 80
gen << col[1].split("\_")[0]
puts line
end
end
bb.close
end
aa.close
########### 	To not miss samples with no blast results:

gen=gen.uniq	
samples.each_index{|a| hsamples[samples[a]] = a}	
gen.each_index{|a| hgen[gen[a]] = a}	
matrix = Array.new(gen.length()) {|index| Array.new(samples.length()) {|x| 0}}

########### 

aa=File.open("list_samples_reads_WMS.txt").each_line do |file|
file.chomp!
sample=file.split("\.")[0]
bb=File.open("#{ARGV[0]}/blastn_#{file}.txt").each_line do |line|
line.chomp!
col=line.split("\t")
if col[2].to_f > 80 and 100*col[3].to_f/col[13].to_f > 80
matrix[hgen[line.split("\t")[1].split("\_")[0]]][hsamples[sample]]+=1
listado.puts "#{file}\t#{line}"
end
end
bb.close
end
aa.close

################################################# Ordena la tabla para colocar las unknown functions al final ##################

# lo de escribir la matriz es copia-pega de internet, alguna 

output=File.new("matrix_resfinder_reads_WMS.txt","w")

mm=-1
samples.each {|i| output.print "\t#{i}"}
output.print "\n"
matrix.each {|i|  mm+=1
output.print "#{gen[mm]}"
i.each {|value| output.print "\t#{value}"}
output.print "\n"
}

