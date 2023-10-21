terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "rep" {
  name       = "github-terraform-task-xyzwxyu"
  visibility = "public"
  auto_init  = true
}

resource "github_branch" "rep" {
  repository = github_repository.rep.name
  branch     = "main"
}

resource "github_branch_default" "rep" {
  repository = github_repository.rep.name
  branch     = "develop"
}

resource "github_repository_file" "rep_pr_template" {
  repository          = github_repository.rep.name
  branch              = github_branch_default.rep.branch
  file                = ".github/pull_request_template.md"
  content             = file(".github/pull_request_template.md")
  overwrite_on_create = true
}

resource "github_repository_file" "rep_codeowners" {
  repository          = github_repository.rep.name
  branch              = github_branch_default.rep.branch
  file                = ".github/CODEOWNERS"
  content             = file(".github/CODEOWNERS")
  overwrite_on_create = true
}
