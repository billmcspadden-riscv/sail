#include "sail.h"
#include "rts.h"
#include "elf.h"

// union option
enum kind_zoption { Kind_zNone };

struct zoption {
  enum kind_zoption kind;
  union {struct { unit zNone; };};
};

static void CREATE(zoption)(struct zoption *op)
{
  op->kind = Kind_zNone;

}

static void RECREATE(zoption)(struct zoption *op) {}

static void KILL(zoption)(struct zoption *op)
{
  if (op->kind == Kind_zNone){
    /* do nothing */
  };
}

static void COPY(zoption)(struct zoption *rop, struct zoption op)
{
  if (rop->kind == Kind_zNone){
    /* do nothing */
  };
  rop->kind = op.kind;
  if (op.kind == Kind_zNone){
    rop->zNone = op.zNone;
  }
}

static bool EQUAL(zoption)(struct zoption op1, struct zoption op2) {
  if (op1.kind == Kind_zNone && op2.kind == Kind_zNone) {
    return EQUAL(unit)(op1.zNone, op2.zNone);
  } else return false;
}

static void zNone(struct zoption *rop, unit op)
{
  if (rop->kind == Kind_zNone){
    /* do nothing */
  }
  rop->kind = Kind_zNone;
  rop->zNone = op;
}



























void zgiraffe1(sail_int *rop, unit);

void zgiraffe1(sail_int *zcbz30, unit zgsz30)
{
  __label__ cleanup_2, end_cleanup_3, end_function_1, end_block_exception_4, end_function_17;

  sail_int zgsz31;
  CREATE(sail_int)(&zgsz31);
  CONVERT_OF(sail_int, mach_int)(&zgsz31, INT64_C(1));
  COPY(sail_int)((*(&zcbz30)), zgsz31);
  goto cleanup_2;
  /* unreachable after return */
  goto end_cleanup_3;
cleanup_2: ;
  KILL(sail_int)(&zgsz31);
  goto end_function_1;
end_cleanup_3: ;
end_function_1: ;
  goto end_function_17;
end_block_exception_4: ;
  goto end_function_17;
end_function_17: ;
}

void zgiraffe2(sail_int *rop, unit);

void zgiraffe3(sail_int *rop, unit);

void zgiraffe3(sail_int *zcbz31, unit zgsz32)
{
  __label__ cleanup_7, end_cleanup_8, end_function_6, end_block_exception_9, end_function_16;

  sail_int zgsz33;
  CREATE(sail_int)(&zgsz33);
  CONVERT_OF(sail_int, mach_int)(&zgsz33, INT64_C(3));
  COPY(sail_int)((*(&zcbz31)), zgsz33);
  goto cleanup_7;
  /* unreachable after return */
  goto end_cleanup_8;
cleanup_7: ;
  KILL(sail_int)(&zgsz33);
  goto end_function_6;
end_cleanup_8: ;
end_function_6: ;
  goto end_function_16;
end_block_exception_9: ;
  goto end_function_16;
end_function_16: ;
}

void zmain(sail_int *rop, unit);

void zmain(sail_int *zcbz32, unit zgsz34)
{
  __label__ cleanup_12, end_cleanup_13, end_function_11, end_block_exception_14, end_function_15;

  sail_int zx1;
  CREATE(sail_int)(&zx1);
  zgiraffe1(&zx1, UNIT);
  sail_int zx2;
  CREATE(sail_int)(&zx2);
  zgiraffe2(&zx2, UNIT);
  sail_int zx3;
  CREATE(sail_int)(&zx3);
  zgiraffe3(&zx3, UNIT);
  sail_int zgsz35;
  CREATE(sail_int)(&zgsz35);
  CONVERT_OF(sail_int, mach_int)(&zgsz35, INT64_C(7));
  COPY(sail_int)((*(&zcbz32)), zgsz35);
  goto cleanup_12;
  /* unreachable after return */
  KILL(sail_int)(&zx3);
  KILL(sail_int)(&zx2);
  KILL(sail_int)(&zx1);
  goto end_cleanup_13;
cleanup_12: ;
  KILL(sail_int)(&zx1);
  KILL(sail_int)(&zx2);
  KILL(sail_int)(&zx3);
  KILL(sail_int)(&zgsz35);
  goto end_function_11;
end_cleanup_13: ;
end_function_11: ;
  goto end_function_15;
end_block_exception_14: ;
  goto end_function_15;
end_function_15: ;
}

void model_init(void)
{
  setup_rts();
}

void model_fini(void)
{
  cleanup_rts();
}

void model_pre_exit()
{
}

int model_main(int argc, char *argv[])
{
  model_init();
  if (process_arguments(argc, argv)) exit(EXIT_FAILURE);
  zmain(UNIT);
  model_fini();
  model_pre_exit();
  return EXIT_SUCCESS;
}

int main(int argc, char *argv[])
{
  return model_main(argc, argv);
}
