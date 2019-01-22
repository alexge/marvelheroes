# marvelheroes

Architecture comments:
- Tried to keep it as simple as possible. The CharacterListController and AppDelegate might make more sense if they were merged, but I wanted the keep the loading segment away from the rest of the app
- Tried to stick to MVC. Theres the one model file, the CharacterListController is the controller for the all the views, and the views don't manage anything except what they display
- I guess the RequestPerformer can technically be considered a singleton, but it doesn't maintain any state, so I let it be


Things to note:
- To clear a search, just trigger an empty search. That will load the full list again
- I thought handling all API errors would involve a lot of extra UI, so there are no network API error handlers
- Have never done UITests before, so thats why there are none
- The persisting of the favorites uses a plist written to disk. If you run the unit test suite on the same sim that you run the app, the test suite will overwrite the disk data, and you will lose your favorites.
- Both of the last companies that I've worked at believed that if you need to write documentation for someone to understand your code, then you need to write better code. I think both schools of thought have merit, but since I haven't been writing any at work, I haven't added any here 

