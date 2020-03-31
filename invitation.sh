#!/bin/sh

DIR=/invites
lang_tag=${QUERY_STRING/*=/}

if [ -f $DIR/invitation_template_${lang_tag}.txt ]; then
  echo -en "Content-Type: text/plain; charset=utf-8\n\n"
  cat $DIR/invitation_template_${lang_tag}.txt
elif [ -f $DIR/invitation_template.txt ]; then
  echo -en "Content-Type: text/plain; charset=utf-8\n\n"
  cat $DIR/invitation_template.txt
else
  echo "Status: 404 (Not Found)"
fi


