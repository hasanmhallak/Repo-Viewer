import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

extension DTOListToDomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDoamin() {
    return map((e) => e.toDoamin()).toList();
  }
}
