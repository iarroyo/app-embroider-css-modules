import { pageTitle } from 'ember-page-title';
import MyCard from '../components/my-card';

<template>
  {{pageTitle "AppEmbroiderCssModules"}}

  <MyCard
    @badge="New"
    @title="CSS Modules in Ember"
    @body="This card uses a scoped .module.css file for its layout and a global .css file for the badge."
  />

  {{outlet}}
</template>
