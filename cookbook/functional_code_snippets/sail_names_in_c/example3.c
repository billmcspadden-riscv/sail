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

