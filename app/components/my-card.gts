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
    Single class → access `styles.<name>` directly.
    No need for {{local}} when you only need one class from the module.
  --}}
  <div class={{styles.card}} ...attributes>
    {{#if @badge}}
      {{!--
        Global class → use a plain string literal.
        `.my-card-badge` is defined in my-card.css and is NOT scoped.
      --}}
      <span class="my-card-badge">{{@badge}}</span>
    {{/if}}

    {{!--
      Multiple classes → use {{local}} to merge them into one string.
      Here "title" is always applied; "highlighted" is added only when
      @highlighted is true. This is the scenario where {{local}} is needed.
    --}}
    <h2 class={{local styles "title" (if @highlighted "highlighted")}}>
      {{@title}}
    </h2>

    {{!--
      Single class again → direct property access is simpler and sufficient.
    --}}
    <p class={{styles.body}}>{{@body}}</p>
  </div>
</template>;

export default MyCard;
