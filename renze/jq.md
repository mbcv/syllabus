>`curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5'`
[
  {
    "sha": "d25341478381063d1c76e81b3a52e0592a7c997f",
    "commit": {
      "author": {
        "name": "Stephen Dolan",
        "email": "mu@netsoc.tcd.ie",
        "date": "2013-06-22T16:30:59Z"
      },
      "committer": {
        "name": "Stephen Dolan",
        "email": "mu@netsoc.tcd.ie",
        "date": "2013-06-22T16:30:59Z"
      },
      "message": "Merge pull request #162 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
      "tree": {
        "sha": "6ab697a8dfb5a96e124666bf6d6213822599fb40",
        "url": "https://api.github.com/repos/stedolan/jq/git/trees/6ab697a8dfb5a96e124666bf6d6213822599fb40"
      },
      "url": "https://api.github.com/repos/stedolan/jq/git/commits/d25341478381063d1c76e81b3a52e0592a7c997f",
      "comment_count": 0
    },
    "url": "https://api.github.com/repos/stedolan/jq/commits/d25341478381063d1c76e81b3a52e0592a7c997f",
    "html_url": "https://github.com/stedolan/jq/commit/d25341478381063d1c76e81b3a52e0592a7c997f",
    "comments_url": "https://api.github.com/repos/stedolan/jq/commits/d25341478381063d1c76e81b3a52e0592a7c997f/comments",
    "author": {
      "login": "stedolan",
...



GitHub returns nicely formatted JSON. For servers that don’t, it can be helpful to pipe the response through jq to pretty-print it. The simplest jq program is the expression ., which takes the input and produces it unchanged as output.

>`curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.'`
[
  {
    "sha": "d25341478381063d1c76e81b3a52e0592a7c997f",
    "commit": {
      "author": {
        "name": "Stephen Dolan",
        "email": "mu@netsoc.tcd.ie",
        "date": "2013-06-22T16:30:59Z"
      },
      "committer": {
        "name": "Stephen Dolan",
        "email": "mu@netsoc.tcd.ie",
        "date": "2013-06-22T16:30:59Z"
      },
      "message": "Merge pull request #162 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
      "tree": {
        "sha": "6ab697a8dfb5a96e124666bf6d6213822599fb40",
        "url": "https://api.github.com/repos/stedolan/jq/git/trees/6ab697a8dfb5a96e124666bf6d6213822599fb40"
      },
      "url": "https://api.github.com/repos/stedolan/jq/git/commits/d25341478381063d1c76e81b3a52e0592a7c997f",
      "comment_count": 0
    },
    "url": "https://api.github.com/repos/stedolan/jq/commits/d25341478381063d1c76e81b3a52e0592a7c997f",
    "html_url": "https://github.com/stedolan/jq/commit/d25341478381063d1c76e81b3a52e0592a7c997f",
    "comments_url": "https://api.github.com/repos/stedolan/jq/commits/d25341478381063d1c76e81b3a52e0592a7c997f/comments",
    "author": {
      "login": "stedolan",
...


We can use jq to extract just the first commit.
`curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.[0]'`

There’s a lot of info we don’t care about there, so we’ll restrict it down to the most interesting fields.
>`jq '.[0] | {message: .commit.message, name: .commit.committer.name}'`
{
  "message": "Merge pull request #162 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
  "name": "Stephen Dolan"
}


.[] returns each element of the array returned in the response, one at a time, which are all fed into {message: .commit.message, name: .commit.committer.name}.

>`jq '.[] | {message: .commit.message, name: .commit.committer.name}'`
{
  "message": "Merge pull request #162 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
  "name": "Stephen Dolan"
}
{
  "message": "Reject all overlong UTF8 sequences.",
  "name": "Stephen Dolan"
}
{
  "message": "Fix various UTF8 parsing bugs.\n\nIn particular, parse bad UTF8 by replacing the broken bits with U+FFFD\nand resychronise correctly after broken sequences.",
  "name": "Stephen Dolan"
}
{
  "message": "Fix example in manual for `floor`. See #155.",
  "name": "Stephen Dolan"
}
{
  "message": "Document floor",
  "name": "Nicolas Williams"
}

If you want to get the output as a single array, you can tell jq to “collect” all of the answers by wrapping the filter in square brackets:

>`jq '[.[] | {message: .commit.message, name: .commit.committer.name}]'`
[
  {
    "message": "Merge pull request #163 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
    "name": "Stephen Dolan"
  },
  {
    "message": "Reject all overlong UTF8 sequences.",
    "name": "Stephen Dolan"
  },
  {
    "message": "Fix various UTF8 parsing bugs.\n\nIn particular, parse bad UTF8 by replacing the broken bits with U+FFFD\nand resychronise correctly after broken sequences.",
    "name": "Stephen Dolan"
  },
  {
    "message": "Fix example in manual for `floor`. See #155.",
    "name": "Stephen Dolan"
  },
  {
    "message": "Document floor",
    "name": "Nicolas Williams"
  }
]


We want to pull out all of the “html_url” fields inside that array of parent commits and make a simple list of strings to go along with the “message” and “author” fields we already have.

>`jq '[.[] | {message: .commit.message, name: .commit.committer.name, parents: [.parents[].html_url]}]'
`
[
  {
    "message": "Merge pull request #162 from stedolan/utf8-fixes\n\nUtf8 fixes. Closes #161",
    "name": "Stephen Dolan",
    "parents": [
      "https://github.com/stedolan/jq/commit/54b9c9bdb225af5d886466d72f47eafc51acb4f7",
      "https://github.com/stedolan/jq/commit/8b1b503609c161fea4b003a7179b3fbb2dd4345a"
    ]
  },
  {
    "message": "Reject all overlong UTF8 sequences.",
    "name": "Stephen Dolan",
    "parents": [
      "https://github.com/stedolan/jq/commit/ff48bd6ec538b01d1057be8e93b94eef6914e9ef"
    ]
  },
  {
    "message": "Fix various UTF8 parsing bugs.\n\nIn particular, parse bad UTF8 by replacing the broken bits with U+FFFD\nand resychronise correctly after broken sequences.",
    "name": "Stephen Dolan",
    "parents": [
      "https://github.com/stedolan/jq/commit/54b9c9bdb225af5d886466d72f47eafc51acb4f7"
    ]
  },
  {
    "message": "Fix example in manual for `floor`. See #155.",
    "name": "Stephen Dolan",
    "parents": [
      "https://github.com/stedolan/jq/commit/3dcdc582ea993afea3f5503a78a77675967ecdfa"
    ]
  },
  {
    "message": "Document floor",
    "name": "Nicolas Williams",
    "parents": [
      "https://github.com/stedolan/jq/commit/7c4171d414f647ab08bcd20c76a4d8ed68d9c602"
    ]
  }
]

