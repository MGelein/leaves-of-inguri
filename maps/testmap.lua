return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 48,
  height = 27,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 5,
  nextobjectid = 33,
  properties = {
    ["name"] = "Testing Fields"
  },
  tilesets = {
    {
      name = "colored_tilemap_packed",
      firstgid = 1,
      filename = "../../../Pictures/colored_tilemap_packed.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 14,
      image = "../../../Pictures/Assets/Kenney Roguelike/kenney_microroguelike_1.2/Tilemap/colored_tilemap_packed.png",
      imagewidth = 112,
      imageheight = 80,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 140,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 1,
      name = "tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        76, 75, 76, 76, 76, 76, 76, 76, 75, 76, 76, 75, 76, 76, 76, 76, 76, 76, 75, 76, 76, 76, 76, 75, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 75, 76, 76, 76, 76, 76, 76, 75, 76, 76, 75, 76, 76, 76,
        76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 75, 76, 76, 75, 76, 76, 76, 76, 16, 16, 16, 16, 61, 16, 76, 76, 76, 76, 76,
        76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 1, 2, 2, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 75, 76,
        76, 76, 76, 76, 16, 16, 16, 62, 16, 16, 16, 16, 16, 15, 16, 16, 18, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76,
        76, 75, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 18, 16, 16, 16, 16, 16, 16, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 75, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 62, 15, 16, 16, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 76, 76, 16, 16, 16, 16, 76, 76, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 29, 16, 16, 32, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 16, 16, 76, 76, 76, 76,
        76, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 75, 76, 76, 76, 75, 76, 75, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 75, 76, 75, 76, 76, 76, 75, 76, 76, 76, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 75, 76, 76, 16, 16, 76, 76, 76, 76, 76, 76, 76,
        76, 16, 16, 61, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 75, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 76,
        76, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        75, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 75, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 76, 16, 16, 16, 16, 16, 16, 75,
        76, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 76, 16, 16, 16, 16, 1, 2, 2, 2, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 75, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 76, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 75, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 61, 16, 16, 16, 16, 75,
        76, 76, 76, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 76, 76, 76, 16, 16, 15, 16, 16, 16, 18, 16, 16, 16, 16, 16, 16, 16, 62, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 76, 75, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 75, 76, 76, 16, 16, 29, 2, 2, 2, 32, 16, 62, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 75, 76, 76, 75, 76, 76, 76, 76, 76, 76, 16, 16, 16, 62, 16, 16, 16, 76, 16, 16, 76,
        76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 76, 76, 75, 76, 76, 76, 76, 76, 75, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        75, 76, 76, 75, 76, 76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76, 76, 76, 76, 75, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 16, 16, 16, 16, 16, 16, 16, 75, 76,
        76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 75, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 75, 76, 76
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 27,
      id = 2,
      name = "entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "collision",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 8,
          height = 216,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 376,
          y = 0,
          width = 8,
          height = 216,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 0,
          width = 368,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 208,
          width = 368,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 152,
          width = 40,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 184,
          width = 40,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 86,
          y = 176,
          width = 2,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 160,
          width = 2,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 16,
          width = 32,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 24,
          width = 2,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 134,
          y = 24,
          width = 2,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 48,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 88,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 104,
          y = 136,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 120,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 184,
          y = 32,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 104,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 128,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 184,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 367.75,
          y = 199.75,
          width = 8.25,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "polygon",
          x = 8,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 0 },
            { x = 16, y = -8 },
            { x = 24, y = -8 },
            { x = 24, y = -24 },
            { x = 32, y = -24 },
            { x = 32, y = -32 },
            { x = 0, y = -32 }
          },
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "polygon",
          x = 208,
          y = 8,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 8 },
            { x = 24, y = 8 },
            { x = 24, y = 16 },
            { x = 72, y = 16 },
            { x = 72, y = 8 },
            { x = 88, y = 8 },
            { x = 88, y = 0 }
          },
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "polygon",
          x = 344,
          y = 8,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 8 },
            { x = 8, y = 8 },
            { x = 8, y = 16 },
            { x = 16, y = 16 },
            { x = 16, y = 24 },
            { x = 24, y = 24 },
            { x = 24, y = 32 },
            { x = 32, y = 32 },
            { x = 32, y = 0 }
          },
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "polygon",
          x = 328,
          y = 72,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -24 },
            { x = 0, y = -32 },
            { x = -16, y = -32 },
            { x = -16, y = -24 },
            { x = -24, y = -24 },
            { x = -24, y = -16 },
            { x = -32, y = -16 },
            { x = -32, y = -8 },
            { x = -40, y = -8 },
            { x = -40, y = 0 },
            { x = -48, y = 0 },
            { x = -48, y = 16 },
            { x = -40, y = 16 },
            { x = -40, y = 24 },
            { x = -24, y = 24 },
            { x = -24, y = 16 },
            { x = -16, y = 16 },
            { x = -16, y = 0 }
          },
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "polygon",
          x = 328,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = 0 },
            { x = 8, y = 8 },
            { x = 24, y = 8 },
            { x = 24, y = 0 },
            { x = 32, y = 0 },
            { x = 32, y = -8 },
            { x = 48, y = -8 },
            { x = 48, y = 32 },
            { x = 0, y = 32 }
          },
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "polygon",
          x = 240,
          y = 136,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -24, y = 0 },
            { x = -24, y = 16 },
            { x = -32, y = 16 },
            { x = -32, y = 24 },
            { x = -40, y = 24 },
            { x = -40, y = 32 },
            { x = -48, y = 32 },
            { x = -48, y = 48 },
            { x = -56, y = 48 },
            { x = -56, y = 56 },
            { x = -64, y = 56 },
            { x = -64, y = 64 },
            { x = -72, y = 64 },
            { x = -72, y = 72 },
            { x = 0, y = 72 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "polygon",
          x = 240,
          y = 136,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -8 },
            { x = 16, y = -8 },
            { x = 16, y = 0 },
            { x = 24, y = 0 },
            { x = 24, y = 24 },
            { x = 32, y = 24 },
            { x = 32, y = 32 },
            { x = 40, y = 32 },
            { x = 40, y = 40 },
            { x = 48, y = 40 },
            { x = 48, y = 48 },
            { x = 56, y = 48 },
            { x = 56, y = 56 },
            { x = 64, y = 56 },
            { x = 64, y = 64 },
            { x = 72, y = 64 },
            { x = 72, y = 72 },
            { x = 0, y = 72 }
          },
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "polygon",
          x = 48,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -8 },
            { x = -8, y = -8 },
            { x = -8, y = -16 },
            { x = -16, y = -16 },
            { x = -16, y = -32 },
            { x = -24, y = -32 },
            { x = -24, y = -40 },
            { x = -32, y = -40 },
            { x = -32, y = -56 },
            { x = -40, y = -56 },
            { x = -40, y = 0 }
          },
          properties = {}
        }
      }
    }
  }
}
