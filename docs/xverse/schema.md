## Xverse Layout

### Model (Version 0.0.0)

### Schema

* Component
 * Definitions and Constraints
    * Progenitor
      * That from which every other Components in any particular Xverse descend, transitively.
      * Its parent is always a Xverse containing no components.
  * Canonical Environment Closure Definitions (in `__SH_OPNM_XVS_V0_ENV_COMPONENT_`)
    * `SELF`
      * `NAME`
      * `SCOPE`
      * `FQDN`
      * `TYPE`
        * `NAME`
        * `SCOPE`
        * `FQTN`
    * `ANCESTORS`
      * `PARENTS`
        * `{FQTN_ASPECT}`
          * `NAME`
          * `SCOPE`
          * `FQTN`
  * Schema (Prototype):
    * `{name}[.{type}[.]}/`
      * `.metadata/`
        * `version`
      * `README.md`
      * `Makefile`
      * `aspects/`
        * `{aspects name}[.{type}[.]]/` -> `Aspect definition (direct or symbolic link)`
        * `[...]`
      * `definition/`
        * `.metadata/`
          * `version`
        * `name`
        * `ports/`
          * `exposed/`
            * `{port name}[.{type}[.]]/`
              * `{mode name}[.{type}[.]]`
          * `consumed/`
            * `{port name}[.{type}[.]]/`
              * `{mode name}[.{type}[.]]`
* Port
  * Definitions and Constraints
    * A point of Connection either provided or consumed by a particular Component
    * Progenitor
  * Canonical Environment Closure Definitions (in `__SH_OPNM_XVS_V0_ENV_PORT_`)
    * `SELF`
      * `NAME`
      * `aspect`
      * `SCOPE`
      * `FQTN`
      * `TYPE`
        * `NAME`
        * `SCOPE`
        * `FQTN`
    * `ANCESTORS`
      * `PARENTS`
        * `{FQTN_ASPECT}`
          * `NAME`
          * `SCOPE`
          * `FQTN`
  * Schema (Prototype):
    * `{name}:[aspect.{type}[.],...]:[.{type}[.]}/`
      * `.metadata/`
        * `version`
      * `README.md`
      * `Makefile`
      * `aspects/`
        * `{aspect name}[.{type}[.]]/` -> `Aspect definition (direct or symbolic link)`
        * `[...]`
      * `definition/`
        * `.metadata/`
          * `version`
        * `name`
        * `modes/`
          * `{local mode name}/` -> `Mode definition (direct or symbolic link)`
      * `relations/`
        * `connections/`
          * `local connection name` -> `Connection`
* Connection
  * Definitions and Constraints
    * Progenitor
      * That from which every other Connection in any particular Xverse descend, transitively.
      * Its parent is always a Xverse containing no Connections and at least one Component which exposes at least one
        Port and at least one Component which imports one Port.
      * Every Connection must have at least one Port
  * Canonical Environment Closure Definitions (in `__SH_OPNM_XVS_V0_ENV_CONNECTION_`)
    * `SELF`
      * `NAME`
      * `SCOPE`
      * `FQDN`
      * `TYPE`
        * `NAME`
        * `SCOPE`
        * `FQTN`
    * `ANCESTORS`
      * `PARENTS`
        * `[FQTN_ASPECT]`
          * `NAME`
          * `SCOPE`
          * `FQTN`
  * Schema (Prototype):
    * `{name}[.{type}[.]]/`
      * `.metadata/`
        * `version`
      * `README.md`
      * `Makefile`
      * `aspects/`
        * `{aspect name}[.{type}[.]]/` -> `aspect definition (direct or symbolic link)`
        * `[...]`
      * `definition/`
        * `.metadata/`
          * `version`
        * `name`
        * `connects/`
          * `ports/`
            * `{local port name}` -> `Port`
          * `in/
            * modes/`
              * `{local mode name}` -> `Port/Mode`