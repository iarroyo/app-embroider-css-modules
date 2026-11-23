import { get } from '@ember/helper';
import { local } from 'embroider-css-modules';

// Local (CSS Modules) — Vite scopes and hashes each class name at build time.
// The import gives us a typed object: styles.card, styles.title, etc.
import styles from './my-card.module.css';

// Global — Vite injects this stylesheet as-is; class names are NOT hashed.
import './my-card.css';

interface MyCardSignature {
  Args: {
    title: string;
    body: string;
    badge?: string;
    /** When true, the title is rendered with the `.highlighted` accent color. */
    highlighted?: boolean;
  };
  Element: HTMLDivElement;
}

const MyCard: TemplateOnlyComponent<MyCardSignature> = <template>
  {{!--
    Single camelCase/single-word class → dot notation works fine.
    No need for {{local}} when you only need one class from the module.
  --}}
  <div class={{styles.card}} ...attributes>
    {{#if @badge}}
      {{!--
        Global class → plain string literal.
        `.my-card-badge` lives in my-card.css and is NOT scoped.
      --}}
      <span class="my-card-badge">{{@badge}}</span>
    {{/if}}

    {{!--
      Multiple classes → use {{local}} to merge them into one string.
      "title" is always applied; "highlighted" is added conditionally.
      This is the scenario where {{local}} is truly needed.
    --}}
    <h2 class={{local styles "title" (if @highlighted "highlighted")}}>
      {{@title}}
    </h2>

    {{!-- Single class, dot notation is sufficient. --}}
    <p class={{styles.body}}>{{@body}}</p>

    {{!--
      Hyphenated class name → dot notation is INVALID in templates
      (styles.read-more would be a syntax error).

      Two valid options:

      1. {{get styles "read-more"}}
         Built-in Ember helper. Good for a single hyphenated class.

      2. {{local styles "read-more"}}
         embroider-css-modules helper. Preferred when you also need
         to combine it with other classes from the same module.
    --}}
    <a href="#" class={{get styles "read-more"}}>Read more</a>
  </div>
</template>;

export default MyCard;
