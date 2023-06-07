class MessageException implements Exception {
  String message;
  MessageException(this.message);
}

class SessionException implements Exception {
  SessionException();
}

class VersionNotSupported implements Exception {
  VersionNotSupported();
}

class ServiceUnavailable implements Exception {
  ServiceUnavailable();
}

class Conflict implements Exception {
  Conflict();
}

class PendingException implements Exception {
  String identifier;
  PendingException(this.identifier);
}

class Unauthorized implements Exception {
  Unauthorized();
}

class FileDimension extends MessageException {
  FileDimension()
      : super("Dimensions autorisé:  800 de largeur X 500 de hauteur.");
}

class FileSize extends MessageException {
  FileSize() : super("Taille des images excessives (8MB maximum).");
}

class FileExtension extends MessageException {
  @override
  FileExtension()
      : super("Seulement les image .PNG/.JPG/.JPEG sont supportés.");
}
