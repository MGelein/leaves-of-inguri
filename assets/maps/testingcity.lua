return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 13,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 5,
  nextobjectid = 26,
  properties = {
    ["bgm"] = "testbgm",
    ["minimap"] = "town",
    ["name"] = "Testing City"
  },
  tilesets = {
    {
      name = "rpgtiles",
      firstgid = 1,
      filename = "tmx/rpgtiles.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 14,
      image = "../graphics/tiles.png",
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
      width = 24,
      height = 13,
      id = 1,
      name = "tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        76, 16, 16, 16, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 1, 2, 2, 2, 2, 4, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 18, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 18, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 29, 2, 2, 16, 2, 32, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 62, 16, 62, 16, 62, 16, 16, 16, 110, 111, 111, 111, 111, 112, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 62, 16, 62, 16, 62, 16, 16, 16, 124, 125, 125, 125, 125, 126, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 62, 16, 62, 16, 62, 16, 16, 16, 138, 139, 139, 139, 139, 140, 16, 76,
        76, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 76,
        76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 13,
      id = 2,
      name = "entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 52, 0, 0, 9, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 38, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          x = 32,
          y = 0,
          width = 152,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 184,
          y = 0,
          width = 8,
          height = 104,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 184,
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
          x = 0,
          y = 0,
          width = 8,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 0,
          width = 24,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 16,
          width = 48,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 40,
          width = 24,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 40,
          width = 16,
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
          x = 128,
          y = 24,
          width = 2,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 174,
          y = 24,
          width = 2,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "polygon",
          x = 128,
          y = 72,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = -8 },
            { x = 40, y = -8 },
            { x = 48, y = 0 },
            { x = 48, y = 8 },
            { x = 40, y = 16 },
            { x = 8, y = 16 },
            { x = 0, y = 8 }
          },
          properties = {
            ["class"] = "water"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "triggers",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 8,
          y = 0,
          width = 24,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["destination"] = "testmap@42,24",
            ["method"] = "collide",
            ["type"] = "warp"
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 136,
          y = 24,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["method"] = "interact",
            ["text"] = "A simple wooden table, showing signs of long and intense use.",
            ["type"] = "text"
          }
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 8,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = "susan",
            ["method"] = "interact",
            ["type"] = "npc"
          }
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 72,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["method"] = "monstersGone",
            ["quest"] = "ratkiller",
            ["state"] = "reward",
            ["type"] = "questState"
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 8,
          width = 8,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["contents"] = "health:2, mana:2, key:2, ring:2",
            ["method"] = "collide",
            ["type"] = "drop"
          }
        }
      }
    }
  }
}
