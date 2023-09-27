import ply.yacc as yacc
from lexer import tokens

def p_program(p):
  '''program : instruction program
              | instruction'''
  p[0] = [p[1]]
  if len(p) == 3:
    p[0] += p[2]

# Preguntar por esta parte
    
def p_instruction(p):
  '''instruction : r_inst
                 | i_inst
                 | li_inst
                 | j_inst
                 | ei_inst
                 | s_inst
                 | b_inst
                 | u_inst
                 | label_inst'''
  p[0] = p[1]
  
def p_r_inst(p):
  'r_inst : TYPE_R REGISTER COMMA REGISTER COMMA REGISTER'
  p[0] = (p[1], p[2], p[4], p[6])
  
def p_i_inst(p):
  '''i_inst : TYPE_I REGISTER COMMA REGISTER COMMA IMMEDIATE
            | TYPE_JI REGISTER COMMA REGISTER COMMA IMMEDIATE'''
  p[0] = (p[1], p[2], p[4], p[6])
  
def p_li_inst(p):
  'li_inst : TYPE_LI REGISTER COMMA IMMEDIATE LPAREN REGISTER RPAREN'
  p[0] = (p[1], p[2], p[4], p[6])
  
def p_j_inst(p):
  'j_inst : TYPE_J REGISTER COMMA LABEL'
  p[0] = (p[1], p[2], p[4])
  
def p_ei_inst(p):
  'ei_inst : TYPE_EI'
  p[0] = (p[1],)
  
def p_s_inst(p):
  's_inst : TYPE_S REGISTER COMMA IMMEDIATE LPAREN REGISTER RPAREN'
  p[0] = (p[1], p[2], p[4], p[6])
  
def p_b_inst(p):
  'b_inst : TYPE_B REGISTER COMMA REGISTER COMMA LABEL'
  p[0] = (p[1], p[2], p[4], p[6])
  
def p_u_inst(p):
  'u_inst : TYPE_U REGISTER COMMA IMMEDIATE'
  p[0] = (p[1], p[2], p[4])
  
def p_label_inst(p):
  'label_inst : LABEL COLON'
  p[0] = p[1]


# Error rule for syntax errors
def p_error(p):
  print("Syntax error in input!")
  print(p)

class Parser:
  def __init__(self):
    self.parser = yacc.yacc()

  def parse(self, data):
    return self.parser.parse(data, debug=0)