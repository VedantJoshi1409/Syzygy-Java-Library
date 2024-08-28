#include "TB_Tablebase.h"

JNIEXPORT void JNICALL Java_TB_Tablebase_init
  (JNIEnv *env, jclass this_class, jstring jPath) {
  const char *path = env->GetStringUTFChars(jPath, NULL);

  tb_init(path);

  env->ReleaseStringUTFChars(jPath, path);
}

JNIEXPORT jlong JNICALL Java_TB_Tablebase_probeDTZ
  (JNIEnv *env, jclass this_class, jlong white, jlong black, jlong king, jlong queen, jlong rook, jlong bishop, jlong knight, jlong pawn, jint rule50, jlong castling, jlong enPassant, jboolean turn) {
  return tb_probe_root(white, black, king, queen, rook, bishop, knight, pawn, rule50, castling, enPassant, turn, NULL);
 }

//gcc -std=gnu99 -Wl,--kill-at -O2 -Wall -D TB_USE_ATOMIC -D TB_NO_HW_POP_COUNT -fPIC -I -I${JAVA_HOME}/include -I${JAVA_HOME}/include/win32 -shared -o tbProbe.dll TB_Tablebase.c