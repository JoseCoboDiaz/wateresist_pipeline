samples=[]
gen=[]
hsamples={}
hgen={}
sample=''

`ls #{ARGV[0]} | sed 's/blastn_//g' > list_samples_contigs_WMS.txt`

listado=File.new("AMR_contigs_blastn_WMS.txt","w")

aa=File.open("list_samples_contigs_WMS.txt").each_line do |file|
file.chomp!
sample=file.split("\.")[0]
samples << sample
#18ac5dd7-4e83-4653-b37f-2a70e6f5d444    lnu(A)_1_M14039 94.652  187     6       4       233     415     486     300     3.54e-78        287     486     TTA
#contig_3        tet(O)_1_M18896 99.792  1920    4       0       1538    3457    1       1920    0.0     3524    1920    ATGA
#contig_10839	OqxB_1_EU370913	75.671	3165	682	73	17316	20436	3121	1	0.0	1498	33319	3153
bb=File.open("#{ARGV[0]}/blastn_#{file}").each_line do |line|
line.chomp!
col=line.split("\t")
#ver que columna ocupa e  longitud de la secuencia objeto (qlength) y la longitud del alineamiento (length) y dividir length entre qlentgh OJO empezar a contar en col 0
puts col[13].to_f/col[3].to_f
if col[2].to_f > 80 and 100*col[3].to_f/col[13].to_f > 80
gen << col[1].split("\_")[0]
contig_with_sample = "#{sample}_#{col[0]}"
      
# Escribir el resultado modificado en el archivo de salida
listado.puts [contig_with_sample, col[1], col[2], col[3], col[4], col[5], col[6], col[7], col[8], col[9], col[10], col[11], col[12], col[13]].join("\t")
end
end
bb.close
end
aa.close
