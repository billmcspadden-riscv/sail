// vim: set tabstop=4 shiftwidth=4 expandtab
// ============================================================================
// Filename:    cfunc.c
//
// Description: Functions to be called by Sail to get values from a yaml file.
//
// Author(s):   Bill McSpadden (bill@riscv.org)
//
// Revision:    See git log
// ============================================================================

#include <sail.h>
#include "cfunc.h"
#include "string.h"
#include <libfyaml.h>


INT_RET_TYPE
cfunc_int(sail_int *zret_int,  char *yaml_filename, char * yaml_key_str)
    {
    struct fy_document      *fyd = NULL;
//  int                     yaml_val_int;
    unsigned int            yaml_val_int;
    int                     count;
    char                    *tmp_str;
    char                    *conversion_str = " %d";

    tmp_str = malloc(strlen(yaml_key_str) + strlen(conversion_str));
    strcpy(tmp_str, yaml_key_str);
    strcat(tmp_str, conversion_str);

    fyd = fy_document_build_from_file(NULL, yaml_filename);
    if ( !fyd )
        {
        fprintf(stderr, "error: failed to build document from yaml file, %s", yaml_filename);
        exit(1);
        }

    count = fy_document_scanf(fyd, tmp_str, &yaml_val_int);
    if (count == 1)
        {
        mpz_set_ui(*zret_int, yaml_val_int);
        }
    else
        {
        fprintf(stderr, "error: value for key, %s,  not found in yaml file, %s\n", yaml_key_str, yaml_filename);
        // TODO: figure out a return mechanism and let caller decide on action.
        exit(1);
        }

    // TODO:  need to de-allocate memory from fy_document_build_from_file()
    free(fyd);
    free(tmp_str);

    return(1);
    }

unit
cfunc_dump_yaml(char *yaml_filename)
    {
    struct fy_document      *fyd = NULL;

    fyd = fy_document_build_from_file(NULL, yaml_filename);
    fy_emit_document_to_fp(fyd, FYECF_DEFAULT | FYECF_SORT_KEYS, stdout);
    free(fyd);
    }

