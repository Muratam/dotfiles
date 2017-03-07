from __future__ import absolute_import
from IPython.core.getipython import get_ipython
from IPython.core.magic import (Magics, magics_class,  cell_magic)
import sys
from markdown import markdown
from IPython.core.display import HTML
changeFormulaDict = [
    (r'&gt;',r'>'),
    (r'&lt;',r'<'),
    (r'∑ (\S+) (\S+)',r'\\SUM{\1}{\2}'),
    (r'S (\S+) (\S+)',r'\\INT{\1}{\2}'),
    (r'(\S+)/(\S+)',r'\\frac{\1}{\2}'),
    (r'§(\S+)',r'\\oint_{\1}'),
    (r'¬(\S+)',r'\\overline{\1}'),
    (r'・・(\S+)',r'\\ddot{\1}'),
    (r'・(\S+)',r'\\dot{\1}'),
    (r'lim (\S+)',r'\\lim_{\1}'),
    (r'hat (\S+)',r'\\hat{\1}'),
    (r'√(\S+)',r'\\sqrt{\1}'),
    (r'oo',r'\\infty '),  
    (r'µ',r'\\mu '),  
    (r'\.∆',r'\\bigtriangledown '),    
    (r'∆',r'\\bigtriangleup '),  
    (r'pi',r' \\pi '),
    (r'forall',r' \\forall '),
    (r'ヨ',r' \\exists '),
    (r' in ',r' \\in '),
    (r'ø',r'\\theta'),
    (r'<=',r'≤'),
    (r'>=',r'≥'),
    (r'\.a',r'\\alpha '),    
    (r'\.b',r'\\beta '),    
    (r'\.c',r'\\gamma '),    
    (r'\.d',r'\\delta '),    
    (r'\.e',r'\\epsilon '),   
    (r'\.E',r'\\xi '),
    (r'\.l',r'\\lambda '),   
    (r'\.m',r'\\mu '),   
    (r'\.n',r'\\eta '),   
    (r'\.o',r'\\theta '), 
    (r'\.p',r'\\varphi '),
    (r'\.r',r'\\rho '),
    (r'\.t',r'\\tau '),  
    (r'\.u',r'\\upsilon '),
    (r'\.v',r'\\nu '),
    (r'\.w',r'\\omega '),     
    (r'\.s',r'\\sigma '),     
    (r'\.x',r'\\chi '),
    (r'\.y',r'\\psi '),
    (r'\.z',r'\\zeta '),   
    (r'\.\|(\S+)',r'\mathbb{\1}'),
    (r';(\S)',r'\mathbb{\1}'),
    (r'\.\^(\S+)',r'\hat{\1}'),
    (r'\^(\S+)',r'^{\1}'),
    (r'＿(\S+)',r'\\zenkakuunderscore{\1}'),

   # (r'　',r'\\,'),
    (r'->',r'\\rightarrow '),    
    (r'\!\{',r'\\left\\{ \\begin{array}{ll}'),
    (r'\!\(',r'\\left( \\begin{array}{ll}'),
    (r'\!\.',r'\\left\\. \\begin{array}{ll}'),
    (r'\!}',r'\\end{array} \\right.'),
    (r'\!\)',r'\\end{array} \\right)'),
    (r' or ',r' \\\\ '),
]
changeJpDict = [
    (r'＃',r'#'),
    (r'　',r' '),
    (r'・',r'- ')
]
# optDict = "6:§, v:√, ^:≠ , j:∆, x:≈, m:µ, ~:±, o:ø, O:Ø, P:∏ 4:¢c:ç"
import re
def replaceAll(k,v,code,i = 0):
    replaced = re.sub(k,v,code) 
    return replaced
    #if replaced == code or i > 10: return code    
    #return replaceAll(k,v,replaced,i + 1)

def te(code) : return tex(code,'$')
def p(code) : return te(code)
def P(code) : return tex(code)
def tex(code,doller = "$$") : 
    for k,v in changeFormulaDict:
        code = re.sub(k,v,code)
    return ( doller + code + doller)


 
@magics_class
class MarkdownMagics(Magics):
    @cell_magic 
    def m(self, line, cell):
        # 日本語または全角：マークダウン
        # 半角アルファベット：数式
        cell = self.toMD72(cell)
        #return cell
        return HTML("<p>{}</p>".format(markdown(cell, extensions=['markdown.extensions.extra'])))
    def toMD72(self,code):    
        formulaAlphabet = r'a-zA-Z0-9\t\r\f\v \-[\]!"#$%&()=~^|@`{}+;*:<,>.?/ø∑ç√§δ'
        formulaAlphabets = r'([' + formulaAlphabet  + r']{2,})' 
        notFormulaAlphabets =  r'([^' + formulaAlphabet  + r']+)'  
        code = re.sub(formulaAlphabets,r'$ \1 $',code)
        for k,v in changeFormulaDict:
            code = replaceAll(k,v,code)
            #code = re.sub(k,v,code)   
        for k,v in changeJpDict:
            code = re.sub(k,v,code)
        #for k,v in changeFormulaDict:
        #m = re.match(formulaAlphabets,code) 
        return code
        
get_ipython().register_magics(MarkdownMagics)

#ESC-A-M :: MarkdownCell

"Python Definition"