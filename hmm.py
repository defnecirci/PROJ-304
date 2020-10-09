#put tag
def copy_to_file(fname1, fname2,fname3):
    with open("./burak/totalproteins.fasta", "a+") as f:
        with open(fname1, "r") as f1:
            lines = f1.readlines()
            for line in lines:
                f.write(line)
        with open(fname2, "r") as f2:
            lines = f2.readlines()
            for line in lines:
                f.write(line)
        with open(fname3, "r") as f3:
            lines = f3.readlines()
            for line in lines:
                f.write(line)


copy_to_file("./burak/aligned_aa_orf7a.fasta", "./burak/aligned_aa_orf8.fasta","./burak/aligned_aa_S.fasta")

#concatenate files
def copy_to_file(fname1, fname2,fname3):
    with open("./burak/totalproteins.fasta", "a+") as f:
        with open(fname1, "r") as f1:
            lines = f1.readlines()
            for line in lines:
                f.write(line)
        with open(fname2, "r") as f2:
            lines = f2.readlines()
            for line in lines:
                f.write(line)
        with open(fname3, "r") as f3:
            lines = f3.readlines()
            for line in lines:
                f.write(line)


copy_to_file("./burak/aligned_aa_orf7a.fasta", "./burak/aligned_aa_orf8.fasta","./burak/aligned_aa_S.fasta")

#find samples
def fa_folder_read(fname, l):
    with open(fname, "r") as f:
        lines = f.readlines()
    with open("subcluster17out.fa", "w") as f:
        out = ''
        index = 0
        flag = False
        country_flag = False
        for line in lines:
            if line[0] == '>':
                if index != 0 and flag:  # if we stored out in cache
                    s = out + '\n'
                    f.write(s)
                    out = ''  # flush out
                k = line[1:line.rfind("_")]
                line = line[1:len(line)-1]
                if k in l:
                    country_flag = True
                    flag = True
                else:
                    flag = False
                index += 1
                if country_flag:
                    country_flag=False
                    f.write(">"+line+"\n")  # write country name
            else:
                if flag:
                    out += line[:len(line)-1]
        s = out + '\n'
        f.write(s)


def get_list(fname):
    with open(fname, "r") as f:
        lines = f.readlines()
    for i in range(len(lines)):
        lines[i]=lines[i].strip()
    return lines


#l = get_list("./mainclustertxtfiles/maincluster4.txt")
l = get_list("./subclustertxtfiles/subcluster17.txt")

fa_folder_read("./burak/totalproteins.fasta", l)

#remove star at the end
def remove_star(fname):
    with open(fname, "r") as f:
        lines = f.readlines()
    with open(fname, "w") as f:
        for line in lines:
            if(line[0] == '>'):
                f.write(line)
            else:
                f.write(line[:-2]+"\n")

remove_star("subcluster17out.fa")

#add all proteins
def add_all_proteins(input,pnames,output):
    with open(input, "r") as f:
        lines = f.readlines()
    with open(pnames, "r") as f:
        names = f.readlines()
    with open(output, "w") as f:
        for name in names:
            f.write(">"+name)
            proteins= [""]*10
            for i in range(len(lines)):
                if lines[i][0]==">" and name[:-1]==lines[i][1:lines[i].rfind("_")]:
                    protein_name= lines[i][lines[i].rfind("_")+1:-1]
                    if protein_name== "ORF1ab":
                        proteins[0]= lines[i+1][:-1]
                    elif protein_name== "Spike":
                        proteins[1]= lines[i+1][:-1]
                    elif protein_name== "ORF3a":
                        proteins[2]= lines[i+1][:-1]
                    elif protein_name== "Envelope":
                        proteins[3]= lines[i+1][:-1]
                    elif protein_name== "Membrane":
                        proteins[4]= lines[i+1][:-1]
                    elif protein_name== "ORF6":
                        proteins[5]= lines[i+1][:-1]
                    elif protein_name== "ORF7a":
                        proteins[6]= lines[i+1][:-1]
                    elif protein_name== "ORF8":
                        proteins[7]= lines[i+1][:-1]
                    elif protein_name== "Nucleocapsid":
                        proteins[8]= lines[i+1][:-1]
                    elif protein_name== "ORF10":
                        proteins[9]= lines[i+1]
            aminoacid= ""
            for protein in proteins:
                aminoacid += protein
            f.write(aminoacid)

add_all_proteins("subcluster17out.fa","./subclustertxtfiles/subcluster17.txt" ,"subcluster17_total_proteins.fa")

