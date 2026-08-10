pub enum Tree {
    Leaf(u32),
    Node(Vec<Tree>),
}

pub fn map_tree(t: Tree) -> Tree {
    match t {
        Tree::Leaf(x) => Tree::Leaf(x + 1),
        Tree::Node(v) => Tree::Node(v.into_iter().map(|e| map_tree(e)).collect()),
    }
}
