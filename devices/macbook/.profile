if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
PATH="$HOME/bin:$PATH"
export PATH
