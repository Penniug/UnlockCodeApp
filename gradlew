#!/usr/bin/env sh

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`/"$link"
    fi
done

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support
case "`uname`" in
  Darwin* )
    DARWIN=true
    ;;
  CYGWIN* )
    CYGWIN=true
    ;;
  MINGW* )
    MINGW=true
    ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum file descriptors if we can.
if [ "$cygwin" = "true" ]; then
    cygpath --version >/dev/null 2>&1 || die "ERROR: cygpath command not found."
fi

# For Darwin, set JAVA_HOME if it's not already set.
if [ "$DARWIN" = "true" ] && [ -z "$JAVA_HOME" ]; then
    JAVA_HOME=`/usr/libexec/java_home` || die "ERROR: JAVA_HOME is not set and /usr/libexec/java_home failed."
fi

# Escape application args
save () {
    echo "$1" | sed 's/\(["\\]\)/\\\1/g'
}

APP_ARGS=""
for arg in "$@"; do
    APP_ARGS="$APP_ARGS \"`save "$arg"`\""
done

eval exec "\"$JAVACMD\" $DEFAULT_JVM_OPTS -classpath \"$CLASSPATH\" org.gradle.wrapper.GradleWrapperMain $APP_ARGS"
