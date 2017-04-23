#! /usr/local/bin/python3
import sys
import subprocess
import os.path
import re
#ipynb -> rst -> tex 
def main():
    # check original file
    if len(sys.argv) != 2 : 
        return print ("wrong arg size")
    originalpath =  sys.argv[1]

    if not originalpath.endswith('.ipynb'):
        return print ("wrong file type")

    # make tempfolder
    tmppath = "tmprst/"
    if not os.path.exists(tmppath) :
        subprocess.call(["mkdir",tmppath])

    # refactor .ipynb
    with open(originalpath,'r') as F:
        print("analyzing ipynb file...")  
        s = F.read()
        s = s.replace(r'&amp;',r'&')
        s = s.replace(r'&gt;',r'>')
        s = s.replace(r'&lt;',r'<')
        # ~/Library/Jupyter/nbextensions/usability/python-markdown/main.js
        # line 41 42
        # added @extenstion
        # text = text.replace(/@@\s*(.+?)\s*@@/g,(m,t,c) => "{{P('" + t + "')}}");
        # text = text.replace(/@\s*(.+?)\s*@/g,(m,t,c) => "{{p('" + t + "')}}");
        s = re.sub(r'@@\s*(.+?)\s*@@',r"{{P('\1')}}",s)
        s = re.sub(r'@\s*(.+?)\s*@',r"{{p('\1')}}",s)
        #print(s)
    tmpipynbpath = tmppath + "tmp.ipynb"
    with open(tmpipynbpath,'w') as F:
        print("creating rst file...")  
        F.write(s) 

        
    # ->.rst
    tmprstfilepath =  "tmp.rst"
    print(tmprstfilepath)
    subprocess.call(["jupyter","nbconvert","--to","rst","--output",tmprstfilepath ,tmpipynbpath])
    tmprstfilepath =  tmppath +  tmprstfilepath  
    if not os.path.exists(tmprstfilepath) : 
        return print("cant make rst file ...")

    # -> .tex
    tmptexfilepath = tmppath +  "tmp.tex"
    subprocess.call(["rst2latex.py",tmprstfilepath,tmptexfilepath]) 
    if not os.path.exists(tmptexfilepath) : 
        return print("cant make tex file ...")    

    # tex refactor
    with open(tmptexfilepath,'r') as F:      
        print("analyzing rst file...")  
        s = F.read()
        s = re.sub(r'\$(\\newcommand.+?)\$',r'\1',s)
        s = re.sub(r'\\begin{quote}.+?jupyterlib72.+?end{quote}',r'',s,flags = re.S)
        s = s.replace(r'\usepackage{amsmath}',"\\usepackage{amsmath}\n\\usepackage{amsfonts}")
        #s = s.replace("\n\n","\n")

    # tex result
    outputtexpath = tmppath + "res.tex"
    with open(outputtexpath,'w') as F:
        print("creating rst file...")  
        F.write(s)            
     
    print("success!!")
    subprocess.Popen(["open",outputtexpath])
    
if __name__ == "__main__" : main()