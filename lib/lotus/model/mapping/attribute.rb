require 'lotus/utils/class'

module Lotus
  module Model
    module Mapping
      # Mapping attribute
      #
      # @api private
      # @since x.x.x
      class Attribute
        # @api private
        # @since x.x.x
        COERCERS_NAMESPACE = "Lotus::Model::Mapping::Coercers".freeze

        # Initialize a new attribute
        #
        # @param name [#to_sym] attribute name
        # @param coercer [.load, .dump] a coercer
        # @param options [Hash] a set of options
        #
        # @option options [#to_sym] :as Resolve mismatch between database column
        #   name and entity attribute name
        #
        # @return [Lotus::Model::Mapping::Attribute]
        #
        # @api private
        # @since x.x.x
        #
        # @see Lotus::Model::Coercer
        # @see Lotus::Model::Mapping::Coercers
        # @see Lotus::Model::Mapping::Collection#attribute
        def initialize(name, coercer, options)
          @name    = name.to_sym
          @coercer = coercer
          @options = options
        end

        # Returns the mapped name
        #
        # @return [Symbol] the mapped name
        #
        # @api private
        # @since x.x.x
        #
        # @see Lotus::Model::Mapping::Collection#attribute
        def mapped
          (@options.fetch(:as) { name }).to_sym
        end

        # @api private
        # @since x.x.x
        def load_coercer
          "#{ coercer }.load"
        end

        # @api private
        # @since x.x.x
        def dump_coercer
          "#{ coercer }.dump"
        end

        # @api private
        # @since x.x.x
        def ==(other)
          self.class     == other.class   &&
            self.name    == other.name    &&
            self.mapped  == other.mapped  &&
            self.coercer == other.coercer
        end

        protected

        # @api private
        # @since x.x.x
        attr_reader :name

        # @api private
        # @since x.x.x
        def coercer
          Utils::Class.load_from_pattern!("(#{ COERCERS_NAMESPACE }::#{ @coercer }|#{ @coercer })")
        end
      end
    end
  end
end
