# Setting Up >> Adding the UI ||20

0. If you haven't yet, install the `@holochain/client`:

```bash
npm install @holochain/client
```

1. Install the module and the necessary packages with:

```bash
npm install @holochain-open-dev/profiles @holochain-open-dev/context @holochain-open-dev/cell-client
```

2. Import the context and profiles elements with:

```js
import "@holochain-open-dev/profiles/define-elements";
import "@holochain-open-dev/context/context-provider";
```

This will define all the elements from this module in the global `CustomElementsRegistry`.

3. Add the context provider **wrapping the whole section of your page in which you are going to be placing** the elements from `@holochain-open-dev/profiles`:

```html
<context-provider id="profiles-context">
  <create-profile-form></create-profile-form>
</context-provider>
```

4. After you connect to Holochain and create the `AppWebsocket`, create the `ProfilesStore` and attach it to the `<context-provider>` element:

```js
import {
  ProfilePrompt,
  SearchAgent,
  ProfilesStore,
  ListProfiles,
  profilesStoreContext
} from "@holochain-open-dev/profiles";
import { AppWebsocket } from "@holochain/client";
import { HolochainClient } from "@holochain-open-dev/cell-client";

const appWebsocket = await AppWebsocket.connect("ws://localhost:8888");
const appInfo = await appWebsocket.appInfo({
  installed_app_id: "test-app",
});

const cellData = appInfo.cell_data[0];
const cellClient = new HolochainClient(appWebsocket, cellData);
const store = new ProfilesStore(cellClient, {
  avatarMode: "avatar",
});

const contextElement = document.getElementById('profiles-context);
contextElement.context = profilesStoreContext;
contextElement.value = store;
```



You can see a full working example of the UI working in [here](https://github.com/holochain-open-dev/profiles/blob/main/ui/demo/index.html).