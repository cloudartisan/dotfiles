#
# Web site
#

# Web SSH aliases
alias sshwww1='ssh -i ~/.ssh/assistly/website.pem ubuntu@www1.assistly.com'
alias sshwww2='ssh -i ~/.ssh/assistly/website.pem ubuntu@www2.assistly.com'



#
# Production
#

# Web SSH aliases
alias sshweb1='ssh -i ~/.ssh/assistly/david_production ${USER}@web1.assistly.com'
alias sshweb2='ssh -i ~/.ssh/assistly/david_production ${USER}@web2.assistly.com'
alias sshweb3='ssh -i ~/.ssh/assistly/david_production ${USER}@web3.assistly.com'
alias sshweb4='ssh -i ~/.ssh/assistly/david_production ${USER}@web4.assistly.com'
alias ubuntu_sshweb1='ssh -i ~/.ssh/assistly/production.pem ubuntu@web1.assistly.com'
alias ubuntu_sshweb2='ssh -i ~/.ssh/assistly/production.pem ubuntu@web2.assistly.com'
alias ubuntu_sshweb3='ssh -i ~/.ssh/assistly/production.pem ubuntu@web3.assistly.com'
alias ubuntu_sshweb4='ssh -i ~/.ssh/assistly/production.pem ubuntu@web4.assistly.com'

# Backend SSH aliases
alias sshbe='ssh -i ~/.ssh/assistly/david_production ${USER}@be.assistly.com'
alias sshbe1='ssh -i ~/.ssh/assistly/david_production ${USER}@be1.assistly.com'
alias sshbe2='ssh -i ~/.ssh/assistly/david_production ${USER}@be2.assistly.com'
alias ubuntu_sshbe='ssh -i ~/.ssh/assistly/production.pem ubuntu@be.assistly.com'
alias ubuntu_sshbe1='ssh -i ~/.ssh/assistly/production.pem ubuntu@be1.assistly.com'
alias ubuntu_sshbe2='ssh -i ~/.ssh/assistly/production.pem ubuntu@be2.assistly.com'

# Search SSH aliases
alias sshsearch='ssh -i ~/.ssh/assistly/david_production ${USER}@search.assistly.com'
alias sshsearch1='ssh -i ~/.ssh/assistly/david_production ${USER}@search1.assistly.com'
alias sshsearch2='ssh -i ~/.ssh/assistly/david_production ${USER}@search2.assistly.com'
alias sshsearch3='ssh -i ~/.ssh/assistly/david_production ${USER}@search3.assistly.com'
alias sshsearch4='ssh -i ~/.ssh/assistly/david_production ${USER}@search4.assistly.com'
alias ubuntu_sshsearch='ssh -i ~/.ssh/assistly/production.pem ubuntu@search.assistly.com'
alias ubuntu_sshsearch1='ssh -i ~/.ssh/assistly/production.pem ubuntu@search1.assistly.com'
alias ubuntu_sshsearch2='ssh -i ~/.ssh/assistly/production.pem ubuntu@search2.assistly.com'
alias ubuntu_sshsearch3='ssh -i ~/.ssh/assistly/production.pem ubuntu@search3.assistly.com'
alias ubuntu_sshsearch4='ssh -i ~/.ssh/assistly/production.pem ubuntu@search4.assistly.com'

# Cache SSH aliases
alias sshcache1='ssh -i ~/.ssh/assistly/david_production ${USER}@cache1.assistly.com'
alias sshcache2='ssh -i ~/.ssh/assistly/david_production ${USER}@cache2.assistly.com'
alias ubuntu_sshcache1='ssh -i ~/.ssh/assistly/production.pem ubuntu@cache1.assistly.com'
alias ubuntu_sshcache2='ssh -i ~/.ssh/assistly/production.pem ubuntu@cache2.assistly.com'



#
# Staging
#

# Web SSH aliases
alias sshstage1='ssh -i ~/.ssh/assistly/david_staging ${USER}@web1.assistlystage.com'
alias sshstage2='ssh -i ~/.ssh/assistly/david_staging ${USER}@web2.assistlystage.com'
alias ubuntu_sshstage1='ssh -i ~/.ssh/assistly/staging.pem ubuntu@web1.assistlystage.com'
alias ubuntu_sshstage2='ssh -i ~/.ssh/assistly/staging.pem ubuntu@web2.assistlystage.com'

# Search SSH aliases
alias sshstagesearch='ssh -i ~/.ssh/assistly/david_staging ${USER}@search.assistlystage.com'
alias sshstagesearch1='ssh -i ~/.ssh/assistly/david_staging ${USER}@search1.assistlystage.com'
alias sshstagesearch2='ssh -i ~/.ssh/assistly/david_staging ${USER}@search2.assistlystage.com'
alias sshstagesearch3='ssh -i ~/.ssh/assistly/david_staging ${USER}@search3.assistlystage.com'
alias sshstagesearch4='ssh -i ~/.ssh/assistly/david_staging ${USER}@search4.assistlystage.com'
alias ubuntu_sshstagesearch='ssh -i ~/.ssh/assistly/staging.pem ubuntu@search.assistlystage.com'
alias ubuntu_sshstagesearch1='ssh -i ~/.ssh/assistly/staging.pem ubuntu@search1.assistlystage.com'
alias ubuntu_sshstagesearch2='ssh -i ~/.ssh/assistly/staging.pem ubuntu@search2.assistlystage.com'
alias ubuntu_sshstagesearch3='ssh -i ~/.ssh/assistly/staging.pem ubuntu@search3.assistlystage.com'
alias ubuntu_sshstagesearch4='ssh -i ~/.ssh/assistly/staging.pem ubuntu@search4.assistlystage.com'

# Build SSH alias
alias sshstagebuilds='ssh -i ~/.ssh/assistly/david_staging ${USER}@builds.assistlystage.com'
alias ubuntu_sshstagebuilds='ssh -i ~/.ssh/assistly/staging.pem ubuntu@builds.assistlystage.com'



#
# Profiling
#

# Web SSH aliases
alias sshprofilingweb1='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingweb1.assistlytest.com'
alias sshprofilingweb2='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingweb2.assistlytest.com'
alias sshprofilingweb3='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingweb3.assistlytest.com'
alias sshprofilingweb4='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingweb4.assistlytest.com'
alias sshprofilingweb5='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingweb5.assistlytest.com'
alias ubuntu_sshprofilingweb1='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingweb1.assistlytest.com'
alias ubuntu_sshprofilingweb2='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingweb2.assistlytest.com'
alias ubuntu_sshprofilingweb3='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingweb3.assistlytest.com'
alias ubuntu_sshprofilingweb4='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingweb4.assistlytest.com'
alias ubuntu_sshprofilingweb5='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingweb5.assistlytest.com'

# Search SSH aliases
alias sshprofilingsearch='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingsearch.assistlytest.com'
alias sshprofilingsearch1='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingsearch1.assistlytest.com'
alias sshprofilingsearch2='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingsearch2.assistlytest.com'
alias sshprofilingsearch3='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingsearch3.assistlytest.com'
alias sshprofilingsearch4='ssh -i ~/.ssh/assistly/david_profiling ${USER}@profilingsearch4.assistlytest.com'
alias ubuntu_sshprofilingsearch='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingsearch.assistlytest.com'
alias ubuntu_sshprofilingsearch1='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingsearch1.assistlytest.com'
alias ubuntu_sshprofilingsearch2='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingsearch2.assistlytest.com'
alias ubuntu_sshprofilingsearch3='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingsearch3.assistlytest.com'
alias ubuntu_sshprofilingsearch4='ssh -i ~/.ssh/assistly/profiling.pem ubuntu@profilingsearch4.assistlytest.com'



#
# QA
#
alias sshqa='ssh -i ~/.ssh/assistly/david_qa ${USER}@web1.assistlyqa.com'
alias ubuntu_sshqa='ssh -i ~/.ssh/assistly/qa.pem ubuntu@web1.assistlyqa.com'

