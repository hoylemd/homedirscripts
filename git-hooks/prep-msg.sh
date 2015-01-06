#! /bin/sh

# To use this, drop it into your /PROJECT/.git/hooks directory and rename it to
#  prepare-commit-msg

# recommended usage: In your repository, create a 'issue_tag' file containing only
#  The issue slug/name/number for your current task. for example, if I am working
#  on issue PRJ-117, the file will just contain 'PRJ-117'
#  Then, when you commit, a newline and 'See #PRF-117' will be appended to the
#  commit message.
# This will also parse commit messages out of branch names, given they are
#  preceeded by 'issue-'. So if my branch is called 'do_stuff_for_issue-hackzorz',
#  my commit message will get 'See #hackzorz' appended.
# Lastly, if you turn prompting on, rhis script will prompt for a tag name if you
#  have failed to specify one in issue_tag or the branch name. This is not intended
#  for regular use - mainly just as a reminder to specify elsewhere without
#  interrupting the workflow too harshly
# If no issue tag is found through any of these methods, the tag line will not be
#  appended and your commit message will be used as-is

issue_file="issue_tag"
prompt="" # set this to "yes" (or any string, really) to prompt for a issue tag
prefix="See #" # this will be prefixed to the issue tag in the message
temp="/tmp/msg.tmp" # temporary place to store the message

# initialize an empty tring for tag
issue=""

# Attempt to read the issue tag from a file
if [ -e $issue_file ]; then
  issue=`cat $issue_file`
fi

# Check the branch name
if [ -z "$issue" ]; then
  issue=$(git symbolic-ref HEAD | awk -F- '/issue-/ {print $2}')
fi

# Prompt the user if prompt is turned on
if [ -z "$issue" ]; then
  if [ -n "$prompt" ]; then
    echo "No issue specified in '$issue_file' or branch name. Please enter one here or blank for no issue tag:"
    read issue
  fi
fi

# append the See line if an issue has been set
if [ -n "$issue" ]; then
  `cat $1 > $temp`
  echo "" >> $temp
  echo "$prefix$issue" >> $temp && mv $temp $1
fi
