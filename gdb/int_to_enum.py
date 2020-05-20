# A command to print a value as if it were a member of a given anonymous
# enumeration.
#
# Usage: penum <val> asif <enumerator>
#
# Example:
#  namespace foo {
#   enum {
#     RED  = 0,
#     BLUE = 1,
#   }
#  }
#
# (gdb) penum 1 asif foo::RED
# foo::BLUE

import gdb

class IntToEnum(gdb.Command):
    def __init__(self):
        super(IntToEnum, self).__init__("penum", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        expr, enum = list(map(str.strip, arg.split("asif")))
        enum_expr = gdb.parse_and_eval(enum)
        enum_type = gdb.types.get_basic_type(enum_expr.type)
        fields = gdb.types.make_enum_dict(enum_type)
        intval = int(gdb.parse_and_eval(expr))
        try:
            print(
                "%s -> %s" % (
                    intval,
                    {v: k for k, v in fields.items()}[intval]
                )
            )
        except KeyError:
            print("no value %d in %s" % (intval, ','.join(fields.keys())))

IntToEnum()
