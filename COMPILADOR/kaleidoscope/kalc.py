from plyplus import Grammar
from MIPSCodeEmitter import MIPSCodeEmitter
from RISCV32CodeEmitter import RISCV32CodeEmitter
from CodeGenerator import CodeGenerator
import sys

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Example call: {} input.kl output.asm".format(sys.argv[0]))
    else:
        sourceFile = sys.argv[1]
        targetFile = sys.argv[2]
        with open('Kaleidoscope.g', 'r') as grm:
            with open(sourceFile, 'r') as sc:
                with open(targetFile, 'w') as oc:
                    scode = sc.read()
                    ast = Grammar(grm, auto_filter_tokens=False).parse(scode)
                    #ast.to_png_with_pydot('ast.png')
                    #TDVisitor(ast)
                    # ce = MIPSCodeEmitter(oc)
                    ce = RISCV32CodeEmitter(oc)
                    cg = CodeGenerator(ce, False)
                    cg.visit(ast)
                    # print(ast)
