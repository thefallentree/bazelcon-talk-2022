def dump():
  return native.existing_rules()

def merge(repos):
    result = {}
    for repo in repos:
      for key in repo:
         if not key in result:
            result[key] = repo[key]
    return json.encode(result)

def _impl(repo_ctx):
  repo_ctx.file("WORKSPACE", '''workspace(name = "%s")''' % repo_ctx.attr.name)
  repo_ctx.file("BUILD", 'exports_files(glob(["all.json"]))')
  repo_ctx.file("all.json", repo_ctx.attr.rules)

dump_repo = repository_rule(
  implementation=_impl,
  attrs={
    "rules": attr.string(mandatory=True)
  },
)
