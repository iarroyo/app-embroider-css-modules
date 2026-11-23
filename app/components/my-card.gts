import { local } from 'embroider-css-modules';

// Local (CSS Modules) — class names are scoped and hashed by Vite
import styles from './my-card.module.css';

// Global — injected as-is; use plain class name strings in the template
import './my-card.css';

interface MyCardSignature {
  Args: {
    title: string;
    body: string;
    badge?: string;
  };
  Element: HTMLDivElement;
}

const MyCard: TemplateOnlyComponent<MyCardSignature> = <template>
  <div class={{local styles "card"}} ...attributes>
    {{#if @badge}}
      {{! .my-card-badge comes from the global my-card.css }}
      <span class="my-card-badge">{{@badge}}</span>
    {{/if}}

    {{! .title and .body come from the CSS module (scoped) }}
    <h2 class={{local styles "title"}}>{{@title}}</h2>
    <p class={{local styles "body"}}>{{@body}}</p>
  </div>
</template>;

export default MyCard;
