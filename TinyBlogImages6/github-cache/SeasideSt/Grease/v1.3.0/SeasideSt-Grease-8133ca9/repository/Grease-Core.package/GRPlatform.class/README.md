The abstract platform implementation. Each platform should provide a subclass implementing any abstract methods and overriding any other methods as necessary.

Default implementations should be provided here when possible/useful but default implementations MUST be valid on ALL PLATFORMS so it is rarely practical. VA Smalltalk flags sends of uknown messages so even these must be known to exist on all platforms.

Common cases where default implementations *are* appropriate are where there is a standard implementation that is valid on all platforms but one or more platforms have an additional, optimized implementation that should be used instead.

All classes and methods used by methods of this class should be either:
  + included in the Seaside-Platform package;
  + defined by the ANSI Smalltalk standard; or
  + (not ideal) referenced via 'Smalltalk at: #ClassName'.